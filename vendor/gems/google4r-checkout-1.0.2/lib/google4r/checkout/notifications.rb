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
    #--
    # TODO: Should this become a Singleton?
    #++
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
    #
    # Note that you must protect the HTTPS request to the piece of code using a 
    # NotificationHandler by HTTP Auth Basic. If you are using Ruby On Rails then you can
    # use the great "simple_http_auth" plugin you can find here:
    # http://blog.codahale.com/2006/05/11/basic-http-authentication-with-rails-simple_http_auth/
    #
    # === Usage Example
    #
    # When you use a Rails controller to handle the calbacks by Google then your action to handle
    # the callbacks could use a NotificationHandler as follows:
    # 
    #  def google_checkout_api
    #    frontend = Google4R::Checkout::Frontend.new(FRONTEND_CONFIGURATION)
    #    frontend.tax_table_factory = CheckoutCommandFactory.new
    #    handler = frontend.create_notification_handler
    #    
    #    begin
    #      notification = handler.handle(request.raw_post) # raw_post contains the XML
    #    rescue Google4R::Checkout::UnknownNotificationType => e
    #      # This can happen if Google adds new commands and Google4R has not been
    #      # upgraded yet. It is not fatal.
    #      render :text => 'ignoring unknown notification type', :status => 200
    #      return
    #    end
    #
    #    # ...
    #  end
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
      #--
      # TODO: Add parsing of other notifications here (merchant calculation and the like) when they have been implemented.
      #++
      def handle(xml_str)
        root = REXML::Document.new(xml_str).root
        
        case root.name
        when 'new-order-notification' then
          NewOrderNotification.create_from_element(root, frontend)
        when 'order-state-change-notification' then
          OrderStateChangeNotification.create_from_element(root, frontend)
        when 'risk-information-notification' then
          RiskInformationNotification.create_from_element(root, frontend)
        when 'charge-amount-notification' then
          ChargeAmountNotification.create_from_element(root, frontend)
        when 'refund-amount-notification' then
          RefundAmountNotification.create_from_element(root, frontend)
        when 'chargeback-amount-notification' then
          ChargebackAmountNotification.create_from_element(root, frontend)
        when 'authorization-amount-notification' then
          AuthorizationAmountNotification.create_from_element(root, frontend)
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
        result.serial_number = element.attributes['serial-number']
        result.google_order_number = element.elements['google-order-number'].text
        result.buyer_billing_address = Address.create_from_element(element.elements['buyer-billing-address'])
        result.buyer_shipping_address = Address.create_from_element(element.elements['buyer-shipping-address'])
        result.buyer_id = element.elements['buyer-id'].text
        result.marketing_preferences = MarketingPreferences.create_from_element(element.elements['buyer-marketing-preferences'])
        result.financial_order_state = element.elements['financial-order-state'].text
        result.fulfillment_order_state = element.elements['fulfillment-order-state'].text
        result.order_adjustment = OrderAdjustment.create_from_element(element.elements['order-adjustment'])
        result.shopping_cart = ShoppingCart.create_from_element(element.elements['shopping-cart'], result)

        amount = (element.elements['order-total'].text.to_f*100).to_i
        currency = element.elements['order-total'].attributes['currency']
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
      
      # Factory method that creates a new OrderStateChangeNotification from an REXML::Element instance.
      # Use this to create instances of OrderStateChangeNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        result = OrderStateChangeNotification.new(frontend)

        result.timestamp = Time.parse(element.elements['timestamp'].text)
        result.serial_number = element.attributes['serial-number']
        result.google_order_number = element.elements['google-order-number'].text
        result.new_financial_order_state = element.elements['new-financial-order-state'].text
        result.previous_financial_order_state = element.elements['previous-financial-order-state'].text
        result.new_fulfillment_order_state = element.elements['new-fulfillment-order-state'].text
        result.previous_fulfillment_order_state = element.elements['previous-fulfillment-order-state'].text
        result.reason = element.elements['reason'].text rescue nil
        
        return result
      end
    end

    # Google Checkout sends <charge-amount-notification> messages to the web service when the
    # to confirm that the charge was successfully executed.
    class ChargeAmountNotification
           
      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # The timestamp of the notification
      attr_accessor :timestamp
      
      # The amount most recently charged for an order (Money)
      attr_accessor :latest_charge_amount
      
      # The total amount charged for an order (Money)
      attr_accessor :total_charge_amount

      # The Frontend instance for this Notification
      attr_accessor :frontend
      
      # Initializes the ChargeAmountNotification instance with the given Frontend instance.
      def initialize(frontend)
        @frontend = frontend
      end

      # Factory method that creates a new ChargeAmountNotification from an REXML::Element instance.
      # Use this to create instances of ChargeAmountNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        charge = ChargeAmountNotification.new(frontend)
        
        charge.serial_number = element.attributes['serial-number']
        charge.google_order_number = element.elements['google-order-number'].text        
        
        currency = element.elements['latest-charge-amount'].attributes['currency'] 
        amount = (element.elements['latest-charge-amount'].text.to_f*100).to_i
        charge.latest_charge_amount = Money.new(amount, currency)
        
        currency = element.elements['total-charge-amount'].attributes['currency']
        amount = (element.elements['total-charge-amount'].text.to_f*100).to_i
        charge.total_charge_amount = Money.new(amount, currency)  
        
        charge.timestamp = Time.parse(element.elements['timestamp'].text)

        return charge
      end
    end

    # Google Checkout sends a <refund-amount-notification> after successfully executing 
    # a <refund-order> order processing command.  See the Google Checkout documentation for more details:
    # http://code.google.com/apis/checkout/developer/index.html#refund_amount_notification
    class RefundAmountNotification
      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # The timestamp of the notification
      attr_accessor :timestamp
      
      # The amount most recently refunded for an order (Money)
      attr_accessor :latest_refund_amount
      
      # The total amount refunded for an order (Money)
      attr_accessor :total_refund_amount

      # The Frontend instance for this Notification
      attr_accessor :frontend
      
      # Initializes the RefundAmountNotification instance with the given Frontend instance.
      def initialize(frontend)
        @frontend = frontend
      end

      # Factory method that creates a new RefundAmountNotification from an REXML::Element instance.
      # Use this to create instances of RefundAmountNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        refund = RefundAmountNotification.new(frontend)
        
        refund.serial_number = element.attributes['serial-number']
        refund.google_order_number = element.elements['google-order-number'].text
        
        currency = element.elements['latest-refund-amount'].attributes['currency']
        amount = (element.elements['latest-refund-amount'].text.to_f*100).to_i
        refund.latest_refund_amount = Money.new(amount, currency)

        currency = element.elements['total-refund-amount'].attributes['currency']
        amount = (element.elements['total-refund-amount'].text.to_f*100).to_i
        refund.total_refund_amount = Money.new(amount, currency)
        
        refund.timestamp = Time.parse(element.elements['timestamp'].text)

        return refund
      end
    end

    # Google Checkout sends a <chargeback-amount-notification> when a customer initiates a 
    # chargeback against the order and Google approves the chargeback.
    # See the Google Checkout documentation for more details:
    # http://code.google.com/apis/checkout/developer/index.html#chargeback_amount_notification
    class ChargebackAmountNotification
      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # The timestamp of the notification
      attr_accessor :timestamp
      
      # The amount most recently charged back for an order (Money)
      attr_accessor :latest_chargeback_amount
      
      # The total amount charged back for an order (Money)
      attr_accessor :total_chargeback_amount

      # The Frontend instance for this Notification
      attr_accessor :frontend
      
      # Initializes the ChargebackAmountNotification instance with the given Frontend instance.
      def initialize(frontend)
        @frontend = frontend
      end

      # Factory method that creates a new ChargebackAmountNotification from an REXML::Element instance.
      # Use this to create instances of ChargebackAmountNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        chargeback = ChargebackAmountNotification.new(frontend)
        
        chargeback.serial_number = element.attributes['serial-number']
        chargeback.google_order_number = element.elements['google-order-number'].text
        
        currency = element.elements['latest-chargeback-amount'].attributes['currency']
        amount = (element.elements['latest-chargeback-amount'].text.to_f*100).to_i
        chargeback.latest_chargeback_amount = Money.new(amount, currency)

        currency = element.elements['total-chargeback-amount'].attributes['currency']
        amount = (element.elements['total-chargeback-amount'].text.to_f*100).to_i
        chargeback.total_chargeback_amount = Money.new(amount, currency)
        
        chargeback.timestamp = Time.parse(element.elements['timestamp'].text)

        return chargeback
      end
    end
    
    # Google Checkout sends an <authorization-amount-notification> in response to a successful
    # request for an explicit credit card reauthorization.
    # See the Google Checkout documentation for more details:
    # http://code.google.com/apis/checkout/developer/index.html#authorization_amount_notification
    class AuthorizationAmountNotification
      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # The timestamp of the notification
      attr_accessor :timestamp
      
      # The amount that is reauthorized to be charged to the customer's credit card (Money)
      attr_accessor :authorization_amount
      
      # The time that a credit card authorization for an order expires.
      attr_accessor :authorization_expiration_date
      
      # The address verification response (String)
      attr_accessor :avs_response
      
      # Credit verification value for the order (String)
      attr_accessor :cvn_response
      
      # The Frontend instance for this Notification
      attr_accessor :frontend
      
      # Initializes the AuthorizationAmountNotification instance with the given Frontend instance.
      def initialize(frontend)
        @frontend = frontend
      end

      # Factory method that creates a new AuthorizationAmountNotification from an REXML::Element instance.
      # Use this to create instances of AuthorizationAmountNotification.
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        authorization = AuthorizationAmountNotification.new(frontend)
        
        authorization.serial_number = element.attributes['serial-number']
        authorization.google_order_number = element.elements['google-order-number'].text
        
        currency = element.elements['authorization-amount'].attributes['currency']
        amount = (element.elements['authorization-amount'].text.to_f*100).to_i
        authorization.authorization_amount = Money.new(amount, currency)

        authorization.authorization_expiration_date = Time.parse(element.elements['authorization-expiration-date'].text)
        
        authorization.avs_response = element.elements['avs-response'].text
        authorization.cvn_response = element.elements['cvn-response'].text
        
        authorization.timestamp = Time.parse(element.elements['timestamp'].text)

        return authorization
      end
    end
    
    # Google Checkout sends out <risk-information-notification> messages for fraud detection
    # related information. See the Google Checkout documentation for more details:
    # http://code.google.com/apis/checkout/developer/index.html#risk_information_notification
    class RiskInformationNotification
      # The serial number of the notification (String).
      attr_accessor :serial_number

      # The order number in Google's database (String).
      attr_accessor :google_order_number

      # Is the order eligible for Google Checkout's payment guarantee policy (boolean).
      attr_accessor :eligible_for_protection
      
      # The buyer's billing address (Address).
      attr_accessor :buyer_billing_address

      # The address verification response (String)
      attr_accessor :avs_response
      
      # Credit verification value for the order (String)
      attr_accessor :cvn_response

      # The last 4 digits of the credit card used to pay for the order (integer)
      attr_accessor :partial_card_number

      # The buyer's IP address (String)
      attr_accessor :ip_address

      # The age of the buyer's google checkout account in days
      attr_accessor :buyer_account_age

      # The timestamp of the notification
      attr_accessor :timestamp
      
      # The Frontend instance for this Notification
      attr_accessor :frontend
      
      # Initializes the RiskInformationNotification instance with the given Frontend instance.
      def initialize(frontend)
        @frontend = frontend
      end

      # Factory method that creates a new RiskInformationNotification from an REXML::Element instance.
      # Use this to create instances of RiskInformationNotification
      #
      # Raises NoMethodError and RuntimeError exceptions if the given element misses required
      # elements.
      def self.create_from_element(element, frontend)
        risk = RiskInformationNotification.new(frontend)
        
        risk.serial_number = element.attributes['serial-number']
        risk.timestamp = Time.parse(element.elements['timestamp'].text)       
        risk.partial_card_number = element.elements['risk-information/partial-cc-number'].text
        risk.ip_address = element.elements['risk-information/ip-address'].text
        risk.google_order_number = element.elements['google-order-number'].text
        risk.eligible_for_protection = element.elements['risk-information/eligible-for-protection'].text == 'true'
        risk.cvn_response = element.elements['risk-information/cvn-response'].text
        risk.buyer_billing_address = Address.create_from_element(element.elements['risk-information/billing-address'])
        risk.buyer_account_age = element.elements['risk-information/buyer-account-age'].text.to_i
        risk.avs_response = element.elements['risk-information/avs-response'].text

        return risk
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
    
    # The marketing preferences of a customer.
    class MarketingPreferences
      # Boolean, true if the customer wants to receive emails.
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
        
        result.type =
          case element.name
          when 'gift-certificate-adjustment' then
            GIFT_CERTIFICATE
          when 'coupon-adjustment' then
            COUPON
          else
            raise ArgumentError, "Invalid tag name: #{element.name} in \n—-\n#{element.to_s}\n—-."
          end
        
        result.code = element.elements['code'].text
        
        amount = (element.elements['calculated-amount'].text.to_f*100).to_i rescue nil
        currency = element.elements['calculated-amount'].attributes['currency'] rescue nil
        result.calculated_amount = Money.new(amount, currency) unless amount.nil?
        
        amount = (element.elements['applied-amount'].text.to_f*100).to_i
        currency = element.elements['applied-amount'].attributes['currency']
        result.applied_amount = Money.new(amount, currency)
        
        result.message = element.elements['message'].text rescue nil
        
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
        
        result.type = 
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
        
        result.name = element.elements['shipping-name'].text
        
        amount = (element.elements['shipping-cost'].text.to_f*100).to_i
        currency = element.elements['shipping-cost'].attributes['currency']
        result.cost = Money.new(amount, currency)
        
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
        
        amount = (element.elements['total-tax'].text.to_f*100).to_i rescue nil
        currency = element.elements['total-tax'].attributes['currency'] rescue nil
        result.total_tax = Money.new(amount, currency) unless amount.nil?
        
        shipping_element = element.elements["shipping/*"]
        result.shipping = ShippingAdjustment.create_from_element(shipping_element) unless shipping_element.nil?
        
        result.merchant_codes = Array.new
        element.elements.each(%q{merchant-codes/*}) { |elem| result.merchant_codes << MerchantCode.create_from_element(elem) }
        
        result.merchant_calculation_successful = (element.elements['merchant-calculation-successful'].text.downcase == 'true') rescue nil
        
        amount = (element.elements['adjustment-total'].text.to_f*100).to_i rescue nil
        currency = element.elements['adjustment-total'].attributes['currency'] rescue nil
        result.adjustment_total = Money.new(amount, currency) unless amount.nil?
        
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
