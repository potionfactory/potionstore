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
require 'base64'
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
      SANDBOX_URL = "https://sandbox.google.com/checkout/cws/v2/Merchant/%s/request"
      
      # The URL to use for real requests to the Google Checkout API. The merchant id
      # is to be put in via String#%.
      PRODUCTION_URL = "https://checkout.google.com/cws/v2/Merchant/%s/request"
      
      # The Frontent class that was used to create this CheckoutCommand and whose
      # configuration will be used.
      attr_reader :frontend

      # Initialize the frontend attribute with the value of the frontend parameter.
      def initialize(frontend)
        @frontend = frontend
      end
      
      # Returns a hash with xml representation of this command and the signature for
      # this representation. Both values are Base64 encoded.
      #
      # This can be used for generating the CheckoutButton when directly posted to
      # Google.
      #
      #   command.sign_and_encode
      #   # => { :cart => 'asdf', :signature => 'asdfasdf' }
      def sign_and_encode
        xml = self.to_xml
        
        # Create a signature of the XML using OpenSSL::HMAC. Note that we do not want a 
        # hexadecimal result from the hash function but a binary result.
        signature = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), 
          frontend.configuration[:merchant_key], xml)
        
        # Create Base64 encoded versions of the XML and the signature.
        encoded_xml = Base64.encode64(xml)
        encoded_signature = Base64.encode64(signature)
        
        return { :cart => encoded_xml, :signature => encoded_signature }
      end

      # Sends the cart's XML to GoogleCheckout via HTTPs with Basic Auth.
      #
      # Raises an OpenSSL::SSL::SSLError when the SSL certificate verification failed.
      #
      # Raises a GoogleCheckoutError when Google returns an error.
      #
      # Raises a RuntimeException on unknown responses.
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
            serial_number = xml_doc.elements['/checkout-redirect/@serial-number'].value
            redirect_url = xml_doc.elements['/checkout-redirect/redirect-url/text()'].value
            return CheckoutRedirectResponse.new(serial_number, redirect_url)
          else
            raise "Unknown response:\n--\n#{xml_doc.to_s}\n--"
          end
        when Net::HTTPClientError then
          xml_doc = REXML::Document.new(result.body)
          
          if xml_doc.elements['/error/@serial-number'].nil? or xml_doc.elements['/error/error-message/text()'].nil? then
            raise "Invalid response from Google:\n---\n#{result.body}\n---"
          end
          
          hash = 
            {
              :serial_number => xml_doc.elements['/error/@serial-number'].value,
              :message       => xml_doc.elements['/error/error-message/text()'].value
            }
          
          raise GoogleCheckoutError.new(hash)
        when Net::HTTPRedirection, Net::HTTPServerError, Net::HTTPInformation then
          raise "Unexpected response code (#{result.class}): #{result.code} - #{result.message}"
        else
          raise "Unknown response code: #{result.code} - #{result.message}"
        end
      end
      
      # Abstract method that is to contain the command's XML representation.
      def to_xml
        raise "Command#to_xml is abstract and must be overridden in a subclass."
      end
      
      protected
      
        # Class method to return the OpenSSL::X509::Store instance for the
        # CA certificates.
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
      attr_reader :cart
      
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
        
        @cart = ShoppingCart.new(self)
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
      # The first shipping method will be used as the default.
      #
      # Raises a RuntimeError if the parameter clazz is invalid.
      def create_shipping_method(clazz, &block)
        if not [ PickupShipping, FlatRateShipping ].include?(clazz) then
          raise "Unknown shipping method: #{type.inspect}."
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
      
      def initialize(serial_number, redirect_url)
        @serial_number = serial_number
        @redirect_url = redirect_url
      end
    end

    class DeliverOrderCommand < Command
      attr_accessor :google_order_number
      attr_accessor :send_email

      # Generates the XML for this CheckoutCommand.
      def to_xml
        return %Q(<?xml version="1.0" encoding="UTF-8"?><deliver-order xmlns="http://checkout.google.com/schema/2" google-order-number="#{self.google_order_number}"><send-email>#{self.send_email}</send-email></deliver-order>)
      end
    end

    class AddMerchantOrderNumberCommand < Command
      attr_accessor :google_order_number
      attr_accessor :merchant_order_number

      # Generates the XML for this CheckoutCommand.
      def to_xml
        return %Q(<?xml version="1.0" encoding="UTF-8"?><add-merchant-order-number xmlns="http://checkout.google.com/schema/2" google-order-number="#{self.google_order_number}"><merchant-order-number>#{self.merchant_order_number}</merchant-order-number></add-merchant-order-number>)
      end
    end

    class ArchiveOrderCommand < Command
      attr_accessor :google_order_number

      def to_xml
        return %Q(<?xml version="1.0" encoding="UTF-8"?><archive-order xmlns="http://checkout.google.com/schema/2" google-order-number="#{self.google_order_number}" />)
      end
    end
    
  end
end
