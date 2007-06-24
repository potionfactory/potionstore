#--
# Project:   google4r
# File:      lib/google4r/checkout/notifications.rb 
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
# This file contains the classes and modules that are used in the notification
# handling code.

require 'rexml/document'

module Google4R #:nodoc:
  module Checkout #:nodoc:
    # Thrown by Notification on unimplemented and unknown notification from Google.
    class UnknownNotificationType < Exception
    end
    
    # Use this objects of this class to tell Google that everything went fine.
    #
    # === Example
    #
    #   render :text => NotificationAcknowledgement.to_xml
    class NotificationAcknowledgement
      def to_xml
        %q{<?xml version="1.0" encoding="UTF-8"?><notification-acknowledgment xmlns="http://checkout.google.com/schema/2"/>}
      end
    end
    
    # This class expects the message sent by Google. It parses the XMl document and returns
    # the appropriate Notification. If the notification sent by Google is invalid then a 
    # UnknownNotificationType is raised that you should catch and then send a 404 to Google
    # to indicate that the notification handler has not been implemented yet.
    #
    # See http://code.google.com/apis/checkout/developer/index.html#notification_api for
    # details.
    #--
    # TODO
    #
    #  * Check HTTP Auth Basic - in Rails?
    #++
    class NotificationHandler
      # The Frontend object that created this NotificationHandler
      attr_accessor :frontend
      
      # Create a new NotificationHandler and assign value of the parameter frontend to
      # the frontend attribute.
      def initialize(frontend)
        @frontend = frontend
      end
      
      # Parses the given xml_str and returns the appropriate *Notification class. At the
      # moment, only NewOrderNotification and OrderStateChangeNotification objects can be
      # returned.
      def handle(xml_str)
        root = REXML::Document.new(xml_str).root
        
        case root.name
        when 'new-order-notification' then
          NewOrderNotification.create_from_element(root, frontend)
        when 'order-state-change-notification' then
          OrderStateChangeNotification.create_from_element(root, frontend)
        else
          raise UnknownNotificationType, "Unknown notification type: #{root.name}"
        end
      end
    end
    
    # Google Checkout sends <new-order-notification> messages to the web service when a new
    # order has been successfully filed with Google Checkout. These messages will be parsed
    # into NewOrderNotification instances.
    class NewOrderNotification
      # The frontend this notification belongs to.
      attr_accessor :frontend
      
      # The serial number of the new order notification (String).
      attr_accessor :serial_number
      
      # The Google order number the new order notification belongs to (String).
      attr_accessor :google_order_number
      
      # The buyer's billing address (Address).
      attr_accessor :buyer_billing_address

      # The buyer's shipping adress (Address).
      attr_accessor :buyer_shipping_address
      
      # The buyer's ID from Google Checkout (String).
      attr_accessor :buyer_id
      
      # The buyer's marketing preferences (MarketingPreferences).
      attr_accessor :marketing_preferences
      
      # The order's financial order state (String, one of FinancialOrderState::*).
      attr_accessor :financial_order_state
      
      # The order's fulfillment state (String, one of FulfillmentOrderState::*).
      attr_accessor :fulfillment_order_state
      
      # The order's number at Google Checkout (String).
      attr_accessor :google_order_number
      
      # The order's total adjustment (OrderAdjustment).
      attr_accessor :order_adjustment
      
      # The order's total amount (Money).
      attr_accessor :order_total
      
      # The order's shopping cart (ShoppingCart)
      attr_accessor :shopping_cart
      
      # The order's timestamp (Time), also see #timestamp=
      attr_accessor :timestamp
      
      # Set the order's timestamp (Time). When the timestamp is set then the tax tables valid 
      # at the given point of time are set into the attribute tax tables from the frontend's
      # tax_table_factory.
      def timestamp=(time)
        @timestamp = time
        @tax_tables = frontend.tax_table_factory.effective_tax_tables_at(time)
      end
      
      # The tax tables for the items in the order notification.
      attr_reader :tax_tables
      
      # Sets the frontend attribute to the value of the frontend parameter.
      def initialize(frontend)
        @frontend = frontend
      end
      
      # Factory method to create a new CheckoutNotification object from the REXML:Element object
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      #
      # You have to pass in the Frontend class this notification belongs to.
      def self.create_from_element(element, frontend)
        result = NewOrderNotification.new(frontend)
        
        result.timestamp = Time.parse(element.elements['timestamp'].text)
        result.serial_number = element.elements['@serial-number'].value
        result.google_order_number = element.elements['google-order-number'].text
        result.buyer_billing_address = Address.create_from_element(element.elements['buyer-billing-address'])
        result.buyer_shipping_address = Address.create_from_element(element.elements['buyer-shipping-address'])
        result.buyer_id = element.elements['buyer-id'].text
        result.marketing_preferences = MarketingPreferences.create_from_element(element.elements['buyer-marketing-preferences'])
        result.financial_order_state = element.elements['financial-order-state'].text
        result.fulfillment_order_state = element.elements['fulfillment-order-state'].text
        result.order_adjustment = OrderAdjustment.create_from_element(element.elements['order-adjustment'])
        result.shopping_cart = ShoppingCart.create_from_element(element.elements['shopping-cart'], result)

        amount = (element.elements['order-total'].text.to_f * 100).to_i rescue nil # TODO: this will break for currencies where 100c != 1d
        currency = element.elements['order-total/@currency'].value rescue nil
        result.order_total = Money.new(amount, currency)
        
        return result
      end
    end

    # GoogleCheckout sends <order-change-notification> messages to the web service when the
    # order's state changes. They will get parsed into OrderStateChangeNotification objects.
    class OrderStateChangeNotification
      # The frontend this notification belongs to.
      attr_accessor :frontend

      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # The previous financial state of the order (String, one of FinancialOrderState::*).
      attr_accessor :previous_financial_order_state

      # The new financial state of the order (String, one of FinancialOrderState::*).
      attr_accessor :new_financial_order_state

      # The previous fulfillment state of the order (String, one of FulfillmentOrderState::*).
      attr_accessor :previous_fulfillment_order_state

      # The new fulfillment state of the order (String, one of FulfillmentOrderState::*).
      attr_accessor :new_fulfillment_order_state

      # The reason for the change (String, can be nil).
      attr_accessor :reason

      # The timestamp of the notification. Also see #timestamp=
      attr_accessor :timestamp

      # Set the order's timestamp (Time). When the timestamp is set then the tax tables valid 
      # at the given point of time are set into the attribute tax tables from the frontend's
      # tax_table_factory.
      def timestamp=(time)
        @timestamp = time
        @tax_tables = frontend.tax_table_factory.effective_tax_tables_at(time)
      end
      
      # The tax tables for the items in the order notification.
      attr_reader :tax_tables
      
      # Sets the frontend attribute to the value of the frontend parameter.
      def initialize(frontend)
        @frontend = frontend
      end
      
      # Factory methdo that creates a new OrderStateChangeNotification from an REXML::Element instance.
      # Use this to create instances of OrderStateChangeNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        result = OrderStateChangeNotification.new(frontend)

        result.timestamp = Time.parse(element.elements['timestamp'].text)

        result.serial_number = element.elements['@serial-number'].value
        result.google_order_number = element.elements['google-order-number'].text
        result.new_financial_order_state = element.elements['new-financial-order-state'].text
        result.previous_financial_order_state = element.elements['previous-financial-order-state'].text
        result.new_fulfillment_order_state = element.elements['new-fulfillment-order-state'].text
        result.previous_fulfillment_order_state = element.elements['previous-fulfillment-order-state'].text
        result.reason = element.elements['reason'].text rescue nil
        
        return result
      end
    end

    # Container for the valid financial order states as defined in the 
    # Google Checkout API.
    module FinancialOrderState
      REVIEWING = "REVIEWING".freeze
      CHARGEABLE = "CHARGEABLE".freeze
      CHARGING = "CHARGING".freeze
      CHARGED = "CHARGED".freeze
      PAYMENT_DECLINED = "PAYMENT_DECLINED".freeze
      CANCELLED = "CANCELLED".freeze
      CANCELLED_BY_GOOGLE = "CANCELLED_BY_GOOGLE".freeze
    end
    
    # Container for the valid fulfillment order states as defined in the 
    # Google Checkout API.
    module FulfillmentOrderState
      NEW = "NEW".freeze
      PROCESSING = "PROCESSING".freeze
      DELIVERED = "DELIVERED".freeze
      WILL_NOT_DELIVER = "WILL_NOT_DELIVER".freeze
    end

    # Address instances are used in NewOrderNotification objects for the buyer's billing
    # and buyer's shipping address.
    class Address
      # Contact name (String, optional).
      attr_accessor :contact_name
      
      # Second Address line (String).
      attr_accessor :address1

      # Second Address line (String optional).
      attr_accessor :address2
      
      # The buyer's city name (String).
      attr_accessor :city
      
      # The buyer's company name (String; optional).
      attr_accessor :company_name
      
      # The buyer's country code (String, 2 chars, ISO 3166).
      attr_accessor :country_code
      
      # The buyer's email address (String; optional).
      attr_accessor :email
      
      # The buyer's phone number (String; optional).
      attr_accessor :fax
      
      # The buyer's phone number (String; Optional, can be enforced in CheckoutCommand).)
      attr_accessor :phone
      
      # The buyers postal/zip code (String).
      attr_accessor :postal_code
      
      # The buyer's geographical region (String).
      attr_accessor :region
      
      # Creates a new Address from the given REXML::Element instance.
      def self.create_from_element(element)
        result = Address.new
        
        result.address1 = element.elements['address1'].text
        result.address2 = element.elements['address2'].text rescue nil
        result.city = element.elements['city'].text
        result.company_name = element.elements['company-name'].text rescue nil
        result.contact_name = element.elements['contact-name'].text rescue nil
        result.country_code = element.elements['country-code'].text
        result.email = element.elements['email'].text rescue nil
        result.fax = element.elements['fax'].text rescue nil
        result.phone = element.elements['phone'].text rescue nil
        result.postal_code = element.elements['postal-code'].text
        result.region = element.elements['region'].text
        
        return result
      end
    end
    
    # The marketing preferences of a customer.
    class MarketingPreferences
      # Boolean, true iff the customer wants to receive emails.
      attr_accessor :email_allowed
      
      # Creates a new MarketingPreferences object from a given REXML::Element instance.
      def self.create_from_element(element)
        result = MarketingPreferences.new
        
        result.email_allowed = (element.elements['email-allowed'].text.downcase == 'true')
        
        return result
      end
    end
    
    # MerchantCodes represent gift certificates or coupons that have been used in an order.
    #
    # Only used with Merchant Calculations.
    class MerchantCode
      GIFT_CERTIFICATE = "GIFT_CERTIFICATE".freeze
      COUPON = "COUPON".freeze
      
      # The type of the adjustment. Can be one of GIFT_CERTIFICATE and COUPON.
      attr_accessor :type
      
      # The adjustment's code (String).
      attr_accessor :code
      
      # The amount of money that has been calculated as the adjustment's worth (Money, optional).
      attr_accessor :calculated_amount
      
      # The amount of the adjustment that has been applied to the cart's total (Money).
      attr_accessor :applied_amount
      
      # The message associated with the direct adjustment (String, optional).
      attr_accessor :message

      # Creates the MerchantCode from the given REXML::Element instance. The Element's
      # name must be "gift-certificate-adjustment" or "coupon-adjustment".
      def self.create_from_element(element)
        result = MerchantCode.new
        
        hash = Hash.new
        hash[:type] =
          case element.name
          when 'gift-certificate-adjustment' then
            GIFT_CERTIFICATE
          when 'coupon-adjustment' then
            COUPON
          else
            raise "Invalid tag name: #{element.name} in \n—-\n#{element.to_s}\n—-."
          end
        hash[:code] = element.elements['code'].text
        hash[:calculated_amount] = (element.elements['calculated-amount'].text.to_f * 100).to_i rescue nil # TODO: this will break for currencies where 100c != 1d
        hash[:calculated_amount_currency] = element.elements['calculated-amount/@currency'].value rescue nil
        hash[:applied_amount] = (element.elements['applied-amount'].text.to_f * 100).to_i # TODO: this will break for currencies where 100c != 1d
        hash[:applied_amount_currency] = element.elements['applied-amount/@currency'].value
        hash[:message] = element.elements['message'].text rescue nil
        
        result.type = hash[:type]
        result.code = hash[:code]
        if not hash[:calculated_amount].nil? then
          result.calculated_amount = Money.new(hash[:calculated_amount], hash[:calculated_amount_currency]) 
        end
        result.applied_amount = Money.new(hash[:applied_amount], hash[:applied_amount_currency])
        result.message = hash[:message] unless hash[:message].nil?
        
        return result
      end
    end
    
    # ShippingAdjustments represent the chosen shipping method.
    class ShippingAdjustment
      MERCHANT_CALCULATED = "MERCHANT_CALCULATED".freeze
      FLAT_RATE = "FLAT_RATE".freeze
      PICKUP = "PICKUP".freeze
      
      # The type of the shipping adjustment, one of MERCHANT_CALCULATED, FLAT_RATE
      # PICKUP.
      attr_accessor :type
      
      # The name of the shipping adjustment.
      attr_accessor :name
      
      # The cost of the selected shipping (Money).
      attr_accessor :cost
      
      # Creates a new ShippingAdjustment object from a REXML::Element object.
      #
      # Can raise a RuntimeException if the given Element is invalid.
      def self.create_from_element(element)
        result = ShippingAdjustment.new
        
        hash = Hash.new
        hash[:type] = 
          case element.name
          when 'flat-rate-shipping-adjustment' then
            FLAT_RATE
          when 'pickup-shipping-adjustment' then
            PICKUP
          when 'merchant-calculated-shipping-adjustment' then
            MERCHANT_CALCULATED
          else
            raise "Unexpected shipping adjustment '#{element.name}'"
          end
        hash[:name] = element.elements['shipping-name'].text
        hash[:cost] = (element.elements['shipping-cost'].text.to_f * 100).to_i # TODO: this will break for currencies where 100c != 1d
        hash[:cost_currency] = element.elements['shipping-cost/@currency'].value
        
        result.type = hash[:type]
        result.name = hash[:name]
        result.cost = Money.new(hash[:cost], hash[:cost_currency])
        
        return result
      end
    end
    
    # OrderAdjustment objects contain the adjustments (i.e. the entities in the cart that 
    # represent positive and negative amounts (at the moment Google Checkout support coupons,
    # gift certificates and shipping)).
    class OrderAdjustment
      # The <adjustment-total> tag contains the total adjustment to an order total based 
      # on tax, shipping, gift certificates and coupon codes (optional).
      attr_accessor :adjustment_total
      
      # Boolean, true iff the merchant calculations have been successful (optional).
      attr_accessor :merchant_calculation_successful
      
      # Array of MerchantCode objects.
      attr_accessor :merchant_codes
      
      # The chosen ShippingAdjustment object for this order.
      attr_accessor :shipping
      
      # The total amount of tax that has been paid for this order (Money, optional).
      attr_accessor :total_tax
      
      # Creates a new OrderAdjustment from a given REXML::Element object.
      def self.create_from_element(element)
        result = OrderAdjustment.new
        
        hash = Hash.new
        hash[:total_tax] = (element.elements['total-tax'].text.to_f * 100).to_i rescue nil # TODO: this will break for currencies where 100c != 1d
        hash[:total_tax_currency] = element.elements['total-tax/@currency'].value rescue nil
        
        shipping_element = element.elements["shipping/*"]
        # the if shipping_element check has been added to avoid an exception -AK
        hash[:shipping] = ShippingAdjustment.create_from_element(shipping_element) if shipping_element
        
        hash[:merchant_codes] = Array.new
        element.elements.each(%q{merchant-codes/*}) do |code_elem|
          hash[:merchant_codes] << MerchantCode.create_from_element(code_elem)
        end
        
        hash[:merchant_calculation_successful] = (element.elements['merchant-calculation-successful'].text.downcase == 'true') rescue nil
        
        hash[:adjustment_total] = (element.elements['adjustment-total'].text.to_f * 100).to_i rescue nil # TODO: this will break for currencies where 100c != 1d
        hash[:adjustment_total_currency] = element.elements['adjustment-total/@currency'].value rescue nil
        
        result.total_tax = Money.new(hash[:total_tax], hash[:total_tax_currency]) unless hash[:total_tax].nil?
        result.adjustment_total = Money.new(hash[:adjustment_total], hash[:adjustment_total_currency]) unless hash[:adjustment_total].nil?
        result.merchant_codes = hash[:merchant_codes] # no unless since the Array is initialized
        result.merchant_calculation_successful = hash[:merchant_calculation_successful]
        result.shipping = hash[:shipping]
        
        return result
      end
    end

    # Class with static methods to parse the <merchant-private(-item)-data> tags.
    class PrivateDataParser
      # Returns a Hash with the representation of the structure in 
      # item/merchant-private-item-data.
      def self.element_to_value(element)
        # The return value; We will iterate over all children below. When we see a REXML::Element
        # child then we set result to a Hash if it is nil. After the result is a Hash, we will
        # ignore all REXML::Text children.
        # Otherwise, result will be set to the REXML::Text node's value if it is not whitespace
        # only.
        result = nil
        
        element.each_child do |child|
          case child
          when REXML::Element
            result ||= Hash.new
            child_value = self.element_to_value(child)

            # <foo>bar</foo>               becomes 'foo' => 'bar
            # <foo>foo</foo><foo>bar</foo> becomes 'foo' => [ 'foo', 'bar' ]
            if result[child.name].nil? then
              result[child.name] = child_value
            elsif result[child.name].kind_of?(Array) then
              result[child.name] << child_value
            else
              tmp = result[child.name]
              result[child.name] = [ tmp, child_value ]
            end
          when REXML::Text
            next if result.kind_of?(Hash) # ignore text if we already found a tag
            str = child.value.strip
            result = str if str.length > 0
          else
            # ignore
          end
        end
        
        return result
      end
    end
  end
end
