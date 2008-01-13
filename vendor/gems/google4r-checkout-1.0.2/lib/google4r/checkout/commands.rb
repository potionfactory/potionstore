#--
# Project:   google4r
# File:      lib/google4r/checkout/commands.rb 
# Author:    Manuel Holtgrewe <purestorm at ggnore dot net>
# Copyright: (c) 2007 by Manuel Holtgrewe
# License:   MIT License as follows:
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the 
# following conditions:
#
# The above copyright notice and this permission notice shall be included 
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
# OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
#++
# This file contains the classes and modules that are used by the command
# generating code.

require 'openssl'
require 'money'
require 'net/http'
require 'net/https'
require 'uri'

module Google4R #:nodoc:
  module Checkout #:nodoc:
    # Abstract super class for all commands that are to be sent to Google. Provides the base
    # functionality for signing and encoding the cart.
    class Command
      # The URL to use for requests to the sandboxed API. The merchant id is to be
      # put in via String#%.
      #--
      # TODO: Move this into a class variable (e.g. via cattr) so it is adaptable.
      #++
      SANDBOX_URL = "https://sandbox.google.com/checkout/cws/v2/Merchant/%s/request"
      
      # The URL to use for real requests to the Google Checkout API. The merchant id
      # is to be put in via String#%.
      #--
      # TODO: Move this into a class variable (e.g. via cattr) so it is adaptable.
      #++
      PRODUCTION_URL = "https://checkout.google.com/cws/v2/Merchant/%s/request"
      
      # The Frontent class that was used to create this CheckoutCommand and whose
      # configuration will be used.
      attr_reader :frontend
      
      # The tag name of the command
      attr_reader :command_tag_name
      
      # The google order number, required, String
      attr_accessor :google_order_number

      # Initialize the frontend attribute with the value of the frontend parameter.
      def initialize(frontend)
        @frontend = frontend
      end

      # Sends the cart's XML to GoogleCheckout via HTTPs with Basic Auth.
      #
      # Raises an OpenSSL::SSL::SSLError when the SSL certificate verification failed.
      #
      # Raises a GoogleCheckoutError when Google returns an error.
      #
      # Raises a RuntimeException on unknown responses.
      #--
      # TODO: The send-and-expect-response part should be adaptable to other commands and responses.
      #++
      def send_to_google_checkout
        # Create HTTP(S) POST command and set up Basic Authentication.
        url_str = 
          if frontend.configuration[:use_sandbox] then
            SANDBOX_URL % frontend.configuration[:merchant_id]
          else
            PRODUCTION_URL % frontend.configuration[:merchant_id]
          end
        url = URI.parse(url_str)
        
        request = Net::HTTP::Post.new(url.path)
        request.basic_auth(frontend.configuration[:merchant_id], frontend.configuration[:merchant_key])

        # Set up the HTTP connection object and the SSL layer.
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        https.cert_store = self.class.x509_store
        https.verify_mode = OpenSSL::SSL::VERIFY_PEER
        https.verify_depth = 5

        # Send the request to Google.
        result = https.request(request, self.to_xml)
        
        case result
        when Net::HTTPSuccess then
          xml_doc = REXML::Document.new(result.body)
          
          case xml_doc.root.name
          when 'checkout-redirect'
            serial_number = xml_doc.elements['/checkout-redirect'].attributes['serial-number']
            redirect_url = xml_doc.elements['/checkout-redirect/redirect-url/text()'].value
            return CheckoutRedirectResponse.new(serial_number, redirect_url)
          when 'request-received'
            serial_number = xml_doc.elements['/request-received'].attributes['serial-number']
            return serial_number
          else
            raise "Unknown response:\n--\n#{xml_doc.to_s}\n--"
          end
        when Net::HTTPClientError then
          xml_doc = REXML::Document.new(result.body)
          
          if xml_doc.elements['/error'].attributes['serial-number'].nil? or xml_doc.elements['/error/error-message/text()'].nil? then
            raise "Invalid response from Google:\n---\n#{result.body}\n---"
          end
          
          hash = 
            {
              :serial_number => xml_doc.elements['/error'].attributes['serial-number'],
              :message       => xml_doc.elements['/error/error-message/text()'].value
            }
          
          raise GoogleCheckoutError.new(hash)
        when Net::HTTPRedirection, Net::HTTPServerError, Net::HTTPInformation then
          raise "Unexpected reponse code (#{result.class}): #{result.code} - #{result.message}"
        else
          raise "Unknown reponse code: #{result.code} - #{result.message}"
        end
      end
      
      # Class method to return the command's XML representation.
      def to_xml
        if self.class == Command then
          raise NotImplementedError, "Command#to_xml has to be used in a subclass."
        else
          generator_class = Google4R::Command.get_const("#{self.class}XmlGenerator")
          return generator_class.new(self).generate
        end
      end
      
      protected
      
      # Class method to return the OpenSSL::X509::Store instance for the
      # CA certificates.
      #--
      # TODO: Is OpenSSL::X509::Store thread safe when reading only? This method most certainly is *not*. It must become so.
      #++
      def self.x509_store
        return @@x509_store if defined?(@@x509_store)
        
        cacert_path = File.expand_path(File.dirname(__FILE__) + '/../../../var/cacert.pem')
        
        @@x509_store = OpenSSL::X509::Store.new
        @@x509_store.add_file(cacert_path)
        
        return @@x509_store
      end
    end

    # The CheckoutCommand represents a <checkout-shopping-cart> command sent
    # to the server.
    #
    # A CheckoutCommand instance can have an arbitrary number of TaxTable
    # and ShippingMethod instances. You must create these instances using the
    # create_* methods which CheckoutCommand supplies.
    # 
    # CheckoutCommand#send_to_google_checkout returns CheckoutRedirectResponse 
    # instances.
    #
    # Use the Frontend class to create new CheckoutCommand instances and do not
    # instanciate the class directly.
    #
    # Note that you have to create/set the tax tables for CheckoutCommands before you
    # can add any items to the cart that define a tax table.
    #
    # === Example
    #
    #   frontend = Google4R::Checkout::Frontend.new(configuration)
    #   frontend.tax_table_factory = TaxTableFactory.new
    #   command = frontend.create_checkout_command
    class CheckoutCommand < Command
      # The ShoppingCart of this CheckoutCommand.
      attr_reader :shopping_cart
      
      # An array of the TaxTable objects of this CheckoutCommand. They have been
      # created with the tax table factory of the frontend which created this
      # command.
      attr_reader :tax_tables
      
      # An array of ShippingMethod objects of this CheckoutCommand. Use 
      # #create_shipping_method to create new shipping methods.
      attr_reader :shipping_methods

      # The URL at where the cart can be edited (String, optional).
      attr_accessor :edit_cart_url
      
      # The URL to continue shopping after completing the checkout (String, optional).
      attr_accessor :continue_shopping_url
      
      # A boolean flag; true iff the customer HAS to provide his phone number (optional).
      attr_accessor :request_buyer_phone_number
      
      # The URL of the merchant calculation callback (optional).
      attr_accessor :merchant_calculations_url
      
      # A boolean flag to indicate whether merchant coupon is supported or not (optional).
      attr_accessor :accept_merchant_coupons

      # A boolean flag to indicate whether gift certificate is supported or not (optional).
      attr_accessor :accept_gift_certificates
      
      # A Google Checkout merchant ID that identifies the eCommerce provider.
      attr_accessor :platform_id
      
      # Generates the XML for this CheckoutCommand.
      def to_xml
        CheckoutCommandXmlGenerator.new(self).generate
      end
      
      # Initialize a new CheckoutCommand with a fresh CheckoutCart and an empty
      # Array of tax tables and an empty array of ShippingMethod instances.
      # Do not use this method directly but use Frontent#create_checkout_command
      # to create CheckoutCommand objects.
      def initialize(frontend)
        super(frontend)
        @shopping_cart = ShoppingCart.new(self)
        @tax_tables = frontend.tax_table_factory.effective_tax_tables_at(Time.new)
        @shipping_methods = Array.new
      end
      
      # Use this method to create a new shipping method. You have to pass in one of
      # { PickupShipping, FlatRateShipping } for clazz. The method will create a 
      # new instance of the class you passedin object and add it to the internal list 
      # of shipping methods.
      #
      # If you pass a block to this method (preferred) then the newly created
      # ShippingMethod object will be passed into this block for setting its attributes.
      # The newly created shipping method will be returned in all cases.
      #
      # The first created shipping method will be used as the default.
      #
      # Raises a ArgumentError if the parameter clazz is invalid.
      def create_shipping_method(clazz, &block)
        if not [ PickupShipping, FlatRateShipping, MerchantCalculatedShipping ].include?(clazz) then
          raise ArgumentError, "Unknown shipping method: #{clazz.inspect}."
        end
        
        shipping_method = clazz.new
        @shipping_methods << shipping_method

        yield(shipping_method) if block_given?
        
        return shipping_method
      end
    end

    # CheckoutRedirectResponse instances are returned when a CheckoutCommand is successfully
    # processed by Google Checkout.
    class CheckoutRedirectResponse
      # The serial number of the <checkout-redirect> response.
      attr_reader :serial_number
      
      # The URL to redirect to.
      attr_reader :redirect_url
      
      # Create a new CheckoutRedirectResponse with the given serial number and redirection URL.
      # Do not create CheckoutRedirectResponse instances in your own code. Google4R creates them
      # for you.
      def initialize(serial_number, redirect_url)
        @serial_number = serial_number
        @redirect_url = redirect_url
      end
    end

    #
    # The ChargeOrderCommand instructs Google Checkout to charge the buyer for a
    # particular order.
    #
    class ChargeOrderCommand < Command
      # The amount to charge, optional, Money
      attr_accessor :amount

      # frontend, required
      def initialize(frontend)
        super(frontend)
      end

      # Generates the XML for this ChargeOrderCommand
      def to_xml
        ChargeOrderCommandXmlGenerator.new(self).generate
      end
    end

    # The RefundOrderCommand instructs Google Checkout to refund an order
    class RefundOrderCommand < Command
      # The amount to refund, optional, Money
      attr_accessor :amount
      
      # The reason that the order is to be refunded, String of maximum 140 characters, required
      attr_accessor :reason
      
      # A comment related to the refunded order, String of maximum 140 characters, optional
      attr_accessor :comment

      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        RefundOrderCommandXmlGenerator.new(self).generate
      end
    end
    
    # The CancelOrderCommand instructs Google Checkout to cancel an order
    class CancelOrderCommand < Command
      # The reason that the order is to be cancelled, String of maximum 140 characters, required
      attr_accessor :reason
      
      # A comment related to the cancelled order, String of maximum 140 characters, optional
      attr_accessor :comment

      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        CancelOrderCommandXmlGenerator.new(self).generate
      end
    end

    # The AuthorizeOrderCommand instructs Google Checkout to explicitly reauthorize
    # a customer's credit card for the uncharged balance of an order to verify that
    # funds for the order are available
    class AuthorizeOrderCommand < Command
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        AuthorizeOrderCommandXmlGenerator.new(self).generate
      end
    end
    
    # The ProcessOrderCommand instructs Google Checkout to to update
    # an order's fulfillment state from NEW to PROCESSING
    class ProcessOrderCommand < Command
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        ProcessOrderCommandXmlGenerator.new(self).generate
      end
    end

    # The AddMerchantOrderCommand instructs Google Checkout to associate a 
    # merchant-assigned order number with an order
    class AddMerchantOrderNumberCommand < Command
      # The merchant-assigned order number associated with an order
      attr_accessor :merchant_order_number
      
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        AddMerchantOrderNumberCommandXmlGenerator.new(self).generate
      end
    end
    
    # The DeliverOrderCommand indicates that Google should update an order's fulfillment order state to DELIVERED
    class DeliverOrderCommand < Command
      # if google checkout should email buyer to ssay order is dispatched
      attr_accessor :send_email
      
      # The name of the company responsible for shipping the item. Valid values
      # for this tag are DHL, FedEx, UPS, USPS and Other.
      attr_accessor :carrier
      
      # The shipper's tracking number that is associated with an order
      attr_accessor :tracking_number
      
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        DeliverOrderCommandXmlGenerator.new(self).generate
      end        
    end
    
    # The AddTrackingDataCommand instructs Google Checkout to associate a shipper's tracking number with an order.
    class AddTrackingDataCommand < Command
      # The name of the company responsible for shipping the item. Valid values
      # for this tag are DHL, FedEx, UPS, USPS and Other.
      attr_accessor :carrier
      
      # The shipper's tracking number that is associated with an order
      attr_accessor :tracking_number
      
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        AddTrackingDataCommandXmlGenerator.new(self).generate
      end        
    end
    
    # The SendBuyerMessageCommand instructs Google Checkout to place a message in the customer's Google Checkout account.
    class SendBuyerMessageCommand < Command
      # The message to the customer
      attr_accessor :message
      
      # if google checkout should email buyer to ssay order is dispatched
      attr_accessor :send_email
      
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        SendBuyerMessageCommandXmlGenerator.new(self).generate
      end        
    end
    
    # The ArchiveOrderCommand instructs Google Checkout to remove an order from your Merchant Center Inbox.
    class ArchiveOrderCommand < Command
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        ArchiveOrderCommandXmlGenerator.new(self).generate
      end
    end
      
    # The UnarchiveOrderCommand instructs Google Checkout to return a previously archived order to your Merchant Center Inbox.
    class UnarchiveOrderCommand < Command
      def initialize(frontend)
        super(frontend)
      end

      def to_xml
        UnarchiveOrderCommandXmlGenerator.new(self).generate
      end
    end
  end
end
