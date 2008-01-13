#--
# Project:   google4r
# File:      lib/google4r/checkout/merchant_calculation.rb 
# Author:    Tony Chan <api dot htchan at gmail dot com>
# Copyright: (c) 2007 by Tony Chan
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
# This file contains the classes and modules that are used in the callback
# handling code.

require 'rexml/document'

module Google4R #:nodoc:
  module Checkout #:nodoc:
    # Thrown by Callback on unimplemented and unknown callbacks from Google.
    class UnknownCallbackType < Exception
    end
    
    # This class expects the message sent by Google. It parses the XMl document and returns
    # the appropriate callback. If the callback sent by Google is invalid then a 
    # UnknownCallbackType is raised that you should catch and then send a 404 to Google
    # to indicate that the callback handler has not been implemented yet.
    #
    # See http://code.google.com/apis/checkout/developer/index.html#merchant_calculations_api for
    # details.
    #
    # Note that you must protect the HTTPS request to the piece of code using a 
    # CallbackHandler by HTTP Auth Basic. If you are using Ruby On Rails then you can
    # use the great "simple_http_auth" plugin you can find here:
    # http://blog.codahale.com/2006/05/11/basic-http-authentication-with-rails-simple_http_auth/
    #
    # === Usage Example
    #
    # When you use a Rails controller to handle the calbacks by Google then your action to handle
    # the callbacks could use a CallbackHandler as follows:
    # 
    #  def google_checkout_api
    #    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    #    frontend.tax_table_factory = TaxTableFactory.new
    #    handler = frontend.create_callback_handler
    #    
    #    begin
    #      callback = handler.handle(request.raw_post) # raw_post contains the XML
    #    rescue Google4R::Checkout::UnknownCallbackType => e
    #      # This can happen if Google adds new commands and Google4R has not been
    #      # upgraded yet. It is not fatal.
    #      render :text => 'ignoring unknown callback type', :status => 200
    #      return
    #    end
    #
    #    # ...
    #  end
    class CallbackHandler
      # The Frontend object that created this CallbackHandler
      attr_accessor :frontend
      
      # Create a new CallbackHandler and assign value of the parameter frontend to
      # the frontend attribute.
      def initialize(frontend)
        @frontend = frontend
      end
      
      # Parses the given xml_str and returns the appropriate *Callback class. At the
      # moment, only MerchantCalculationCallback objects can be returned.
      def handle(xml_str)
        root = REXML::Document.new(xml_str).root
        
        case root.name
        when 'merchant-calculation-callback' then
          MerchantCalculationCallback.create_from_element(root, frontend)
        else
          raise UnknownCallbackType, "Unknown callback type: #{root.name}"
        end
      end
    end
    
    # Google Checkout send a <merchant-calculation-callback> message to you when any of the
    # events occur:
    #   The customer signs in to Google Checkout.
    #   The customer enters a new shipping address on the Place Order page.
    #   The customer enters a coupon or gift certificate code.
    #
    # The message will be parsed into a MerchantCalculationCallback instance.
    #
    class MerchantCalculationCallback
      # The frontend this callback belongs to.
      attr_accessor :frontend

      # The order's shopping cart (ShoppingCart)
      attr_accessor :shopping_cart
      
      # The buyer's language
      attr_accessor :buyer_language
            
      # An array of AnonymousAddress objects of this callback.
      attr_reader :anonymous_addresses
         
      # This indicates whether the merchant needs to calculate taxes for the order.
      attr_accessor :tax
      
      # An array of shipping method names
      attr_reader :shipping_methods
      
      # An array of merchant codes
      attr_reader :merchant_code_strings
      
      # Sets the frontend attribute to the value of the frontend parameter.
      def initialize(frontend)
        @frontend = frontend
        @anonymous_addresses = Array.new
        @shipping_methods = Array.new
        @merchant_code_strings = Array.new
      end
      
      # Factory method to create a new MerchantCalculationCallback object from 
      # the REXML:Element object
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      #
      # You have to pass in the Frontend class this callback belongs to.
      def self.create_from_element(element, frontend)
        result = MerchantCalculationCallback.new(frontend)
        
        result.shopping_cart = ShoppingCart.create_from_element(element.elements['shopping-cart'], result)
        result.buyer_language = element.elements['buyer-language'].text
        element.elements.each('calculate/addresses/anonymous-address') do |address_element|
          result.anonymous_addresses << AnonymousAddress.create_from_element(address_element)
        end
        result.tax = element.elements['calculate/tax'].text
        element.elements.each('calculate/shipping/method') do |shipping_method_element|
          result.shipping_methods << shipping_method_element.attributes['name']
        end
        element.elements.each('calculate/merchant-code-strings/merchant-code-string') do |merchant_code_string_element|
          result.merchant_code_strings << merchant_code_string_element.attributes['code']
        end
        
        return result
      end
    end
    
    # This class represents a merchant-calculation-results XML
    # 
    # === Usage Sample
    #
    # results = MerchantCalculationResults.new
    # coupon_result = CouponResult.new(true, 'FirstVisitCoupon', Money.new(500, 'USD'), 'Congratulations! You saved $5.00 on your first visit!')
    # gift_certificate_result = GiftCertificateResult.new(true, 'GiftCert012345', Money.new(1000, 'USD'), 'You used your Gift Certificate!')
    #
    # results.create_merchant_calculation_result do |result|
    #   result.shipping_name = 'SuperShip'
    #   result.address_id = '739030698069958'
    #   result.shipping_rate = Money.new(703, 'USD')
    #   result.shippable = true
    #   result.total_tax = Money.new(1467, 'USD')
    #   result.create_merchant_code_result(@coupon_result)
    #   result.create_merchant_code_result(@gift_certificate_result)
    # end
    #
    # results.create_merchant_calculation_result do |result|
    #   result.shipping_name = 'UPS Ground'
    #   result.address_id = '739030698069958'
    #   result.shipping_rate = Money.new(556, 'USD')
    #   result.shippable = true
    #   result.total_tax = Money.new(1467, 'USD')
    #   result.create_merchant_code_result(@coupon_result)
    #   result.create_merchant_code_result(@gift_certificate_result)
    # end
    #
    # results.to_xml # To create the XML to return to Google
    #
    class MerchantCalculationResults
      # An array of merchant calcuation results
      attr_reader :merchant_calculation_results
      
      def initialize()
        @merchant_calculation_results = Array.new
      end
      
      # This method takes a MerchantCalculationResult object and add it to the
      # merchant_calculation_results array.  If the object is not provided, it will
      # instantiate one and add it to the array.  An optional code block can be
      # supplied to set the attributes of the new MerchantCalculationResult object.
      #
      # Raises RuntimeError exceptions if the given object is not of type
      # MerchantCalculationResult.
      def create_merchant_calculation_result(result=nil, &block)
        if result.nil?
          result = MerchantCalculationResult.new
          # Pass the newly generated item to the given block to set its attributes.
          yield(result) if block_given?
        else
          raise "Not a MerchantCalculationResult!" unless result.kind_of?(MerchantCalculationResult)
        end
        @merchant_calculation_results << result
      end
      
      def to_xml()
        return MerchantCalculationResultsXmlGenerator.new(self).generate()
      end
    end
    
    # The class represnts a merchant-calculation-result in the merchant-calculation-results XML
    class MerchantCalculationResult
      # The shipping name (string)
      attr_accessor :shipping_name
      
      # The address id (string)
      attr_accessor :address_id
      
      # The shipping rate (Money)
      attr_accessor :shipping_rate
      
      # Is it this applicable to this order (boolean)
      attr_accessor :shippable 
      
      # The total tax (Money)
      attr_accessor :total_tax
      
      # An array of merchant code results
      attr_reader :merchant_code_results
      
      def initialize(shipping_name='', address_id='', shipping_rate=nil, shippable=false, total_tax=nil)
        @shipping_name = shipping_name
        @address_id = address_id
        @shipping_rate = shipping_rate
        @shippable = shippable
        @total_tax = total_tax
        @merchant_code_results = Array.new
      end
      
      # This method takes either a CouponResult or GiftCertificateResult object and 
      # add it to the merchant_code_results array.  If the Class object of either
      # the two types is provided, it will create an instance from the Class object.
      # An optional code block can be supplied to set the attributes of the new 
      # object.
      #
      # Raises RuntimeError exceptions if there is no argument or a wrong class
      # type is provided.
      def create_merchant_code_result(result=nil, &block)
        if !result.nil?
          if [ CouponResult, GiftCertificateResult ].include?(result) # is a Class object
            result = result.new
          else
            raise "Invalid Merchant Code Result class type: #{result.class}!" unless 
              (result.kind_of?(CouponResult) || result.kind_of?(GiftCertificateResult))
          end
        else
          raise "You must either provide a MerchantCodeResult Class type or a CoupleResult or GiftCertificateResult instance."
        end
        @merchant_code_results << result

        # Pass the newly generated item to the given block to set its attributes.
        yield(result) if block_given?
        
      end
    end
    
    # Base class for merchant code (coupon and gift certificate)
    class CodeResult
      # Is this valid (boolean)
      attr_accessor :valid
      
      # The code (string)
      attr_accessor :code
      
      # The calculated amount (Money)
      attr_accessor :calculated_amount
      
      # The message (string)
      attr_accessor :message
      
      def initialize()
        raise "Do not use the abstract class Google::Checkout::CodeReslt"
      end
    end
    
    # This class represents a coupon-result in the merchant-calculation-results XML
    class CouponResult < CodeResult
      def initialize(valid=false, code='', calculated_amount=nil, message='')
        @valid = valid
        @code = code
        @calculated_amount = calculated_amount
        @message = message
      end
    end

    # This class represents a gift-certificate-result in the merchant-calculation-results XML
    class GiftCertificateResult < CodeResult
      def initialize(valid=false, code='', calculated_amount=nil, message='')
        @valid = valid
        @code = code
        @calculated_amount = calculated_amount
        @message = message
      end
    end
  end
end
