#--
# Project:   google4r
# File:      lib/google4r/checkout/xml_generation.rb
# Authors:   Manuel Holtgrewe <purestorm at ggnore dot net>
#            Tony Chan <api.htchan at gmail dot com>
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
# This file contains the classes that allow to persist the object hierarchies
# that are created with the Google Checkout API to XML.

require 'stringio'
require 'rexml/document'

module Google4R #:nodoc:
  module Checkout #:nodoc:
    
    class XmlGenerator
      # Base method to generate the XML for a particular command
      def generate
        @document = REXML::Document.new
        
        declaration = REXML::XMLDecl.new
        declaration.encoding = 'utf-8'
        @document << declaration
      end
    end
    
    # Abstract super class for all CommandXmlGenerators
    # It should never be instantiated directly
    class CommandXmlGenerator < XmlGenerator
      
      # The list of command tag names
      COMMAND_TO_TAG =
      {
        ChargeOrderCommand => "charge-order",
        RefundOrderCommand => "refund-order",
        CancelOrderCommand => "cancel-order",
        AuthorizeOrderCommand => "authorize-order",
        ProcessOrderCommand => "process-order",
        AddMerchantOrderNumberCommand => "add-merchant-order-number",
        DeliverOrderCommand  => "deliver-order",
        AddTrackingDataCommand => "add-tracking-data",
        SendBuyerMessageCommand => "send-buyer-message",
        ArchiveOrderCommand => "archive-order",
        UnarchiveOrderCommand => "unarchive-order"
      }
      
      def initialize(command)
        super()
        @command = command
      end
      
      # Base method to generate the XML for a particular command
      def generate
        super()
        self.process_command(@command)
        io = StringIO.new
        @document.write(io, 0) # TODO: Maybe replace 0 by -1 so no spaces are inserted?
        return io.string
      end

      def tag_name_for_command(klass)
        COMMAND_TO_TAG[klass]
      end
      
      protected
      
      # Base method to generate root tag of a command
      def process_command(command)
        tag_name = self.tag_name_for_command(command.class)
        root = @document.add_element(tag_name)
        root.add_attribute('google-order-number', command.google_order_number)
        root.add_attribute('xmlns', 'http://checkout.google.com/schema/2')
        return root;
      end
    end
    
    # Use the CheckoutXmlGenerator to create an XML document from a CheckoutCommand
    # object.
    #
    # Usage:
    #
    #   checkout = CheckoutCommand.new
    #   # set up the CheckoutCommand
    #   
    #   generator = CheckoutCommandXmlGenerator.new(checkout)
    #   puts generator.generate # => "<xml? version=..."
    #   File.new('some.xml', 'w') { |f| f.write generator.generate }
    #--
    # TODO: Refactor the big, monolitic generator into smaller, easier testable ones. One for each major part of the resulting XML document. This will also reduce the overhead in generating other types of XML documents.
    #++
    class CheckoutCommandXmlGenerator < CommandXmlGenerator
      
      protected
      
      def process_command(command)
        root = @document.add_element("checkout-shopping-cart" , { 'xmlns' => 'http://checkout.google.com/schema/2' })
        
        self.process_shopping_shopping_cart(root, command.shopping_cart)
        
        # <merchant-checkout-flow-support>
        flow_element = root.add_element('checkout-flow-support').add_element('merchant-checkout-flow-support')

        # <tax-tables>
        if command.tax_tables then
          self.process_tax_tables(command.tax_tables, flow_element)
        end

        # <continue-shopping-url>
        if not command.continue_shopping_url.nil? then
          flow_element.add_element('continue-shopping-url').text = command.continue_shopping_url
        end
        
        # <edit-cart-url>
        if not command.edit_cart_url.nil? then
          flow_element.add_element('edit-cart-url').text = command.edit_cart_url
        end
        
        # <request-buyer-phone-number>
        if not command.request_buyer_phone_number.nil? then
          flow_element.add_element('request-buyer-phone-number').text =
            if command.request_buyer_phone_number then
              "true"
            else
              "false"
            end
        end
       
        # <merchant-calculations>
        if not command.merchant_calculations_url.nil? then
          merchant_calculations = flow_element.add_element('merchant-calculations')
          merchant_calculations.add_element('merchant-calculations-url').text =
            command.merchant_calculations_url
          if not command.accept_merchant_coupons.nil? then
            merchant_calculations.add_element('accept-merchant-coupons').text =
              command.accept_merchant_coupons.to_s
          end
          if not command.accept_gift_certificates.nil? then
            merchant_calculations.add_element('accept-gift-certificates').text =
              command.accept_gift_certificates.to_s
          end
        end
        
        # <platform-id>
        if not command.platform_id.nil? then
          flow_element.add_element('platform-id').text = command.platform_id
        end
        
        # <shipping-methods>
        shippings_element = flow_element.add_element('shipping-methods')
        command.shipping_methods.each do |shipping_method|
          self.process_shipping_method(shippings_element, shipping_method)
        end
      end
      
      # adds the tax-tables to the parent xml element
      # assumes that the first member of the tax_tables array is the default tax rule table
      # and that all others are alternate tax rules
      def process_tax_tables(tax_tables, parent)
        tax_tables_element = parent.add_element('tax-tables')

        # assumes that the first tax table is the default
        default_table = tax_tables.first
        
        default_table_element = tax_tables_element.add_element('default-tax-table')
        rules_element = default_table_element.add_element('tax-rules')

        default_table.rules.each do |rule|
          default_rule_element = rules_element.add_element('default-tax-rule')
          default_rule_element.add_element('shipping-taxed').text=rule.shipping_taxed.to_s
          default_rule_element.add_element('rate').text=rule.rate.to_s
          self.process_area(default_rule_element.add_element('tax-area'), rule.area)
        end

        # populate alternate tax tables
        alt_tables = tax_tables.last(tax_tables.length-1)
        alt_tables_element = tax_tables_element.add_element('alternate-tax-tables')

        alt_tables.each do |table|
          table_element = alt_tables_element.add_element('alternate-tax-table')
          table_element.add_attribute('name', table.name)
          table_element.add_attribute('standalone', table.standalone.to_s)

          rules_element = table_element.add_element('alternate-tax-rules')
          table.rules.each do |rule|
            alt_rule_element = rules_element.add_element('alternate-tax-rule')
            alt_rule_element.add_element('rate').text=rule.rate.to_s

            self.process_area(alt_rule_element.add_element('tax-area'), rule.area)
          end
        end         
      end


      def process_shopping_shopping_cart(parent, shopping_cart)
        cart_element = parent.add_element('shopping-cart')
        
        # add <cart-expiration> tag to the cart if a time has been added to the cart
        if not shopping_cart.expires_at.nil? then
          cart_element.add_element('cart-expiration').add_element('good-until-date').text =
            shopping_cart.expires_at.iso8601
        end
        
        # add <merchant-private-data> to the cart if any has been set
        if not shopping_cart.private_data.nil? then
          self.process_hash(cart_element.add_element('merchant-private-data'), shopping_cart.private_data)
        end
        
        # process the items in the cart
        items_element = cart_element.add_element('items')
        shopping_cart.items.each do |item|
          self.process_item(items_element, item)
        end
      end
      
      # Adds an <item> tag to the tag parent with the appropriate values.
      def process_item(parent, item)
        item_element = parent.add_element('item')
        
        item_element.add_element('item-name').text = item.name
        item_element.add_element('item-description').text = item.description
        
        item_element.add_element('unit-price', { 'currency' => item.unit_price.currency }).text = item.unit_price.to_s
        item_element.add_element('quantity').text = item.quantity.to_i
        
        if not item.id.nil? then
          item_element.add_element('merchant-item-id').text = item.id 
        end
        
        if not item.private_data.nil? then
          self.process_hash(item_element.add_element('merchant-private-item-data'), item.private_data)
        end
        
        # The above was easy; now we need to get the appropriate tax table for this
        # item. The Item class makes sure that the table exists.
        if not item.tax_table.nil? then
          item_element.add_element('tax-table-selector').text = item.tax_table.name
        end
      end
      
      # Adds an item for the given shipping method.
      def process_shipping_method(parent, shipping_method)
        if shipping_method.kind_of? PickupShipping then
          process_pickup(parent, shipping_method)
        elsif shipping_method.kind_of? FlatRateShipping then
          process_shipping('flat-rate-shipping', parent, shipping_method)
        elsif shipping_method.kind_of? MerchantCalculatedShipping then
          process_shipping('merchant-calculated-shipping', parent, shipping_method)
        else
          raise "Unknown ShippingMethod type of #{shipping_method.inspect}!"
        end
      end
      
      def process_shipping(shipping_type, parent, shipping)
        element = parent.add_element(shipping_type)
        element.add_attribute('name', shipping.name)
        element.add_element('price', { 'currency' => shipping.price.currency }).text = shipping.price.to_s
        
        if shipping.shipping_restrictions_excluded_areas.length + 
           shipping.shipping_restrictions_allowed_areas.length > 0 then
          shipping_restrictions_tag = element.add_element('shipping-restrictions')
          
          if shipping.shipping_restrictions_allowed_areas.length > 0 then
            allowed_tag = shipping_restrictions_tag.add_element('allowed-areas')
            
            shipping.shipping_restrictions_allowed_areas.each do |area|
              self.process_area(allowed_tag, area)
            end
          end
        
          if shipping.shipping_restrictions_excluded_areas.length > 0 then
            excluded_tag = shipping_restrictions_tag.add_element('excluded-areas')

            shipping.shipping_restrictions_excluded_areas.each do |area|
              self.process_area(excluded_tag, area)
            end
          end
        end

        if shipping.kind_of? MerchantCalculatedShipping then
          if shipping.address_filters_excluded_areas.length + 
             shipping.address_filters_allowed_areas.length > 0 then
            address_filters_tag = element.add_element('address-filters')
            
            if shipping.address_filters_allowed_areas.length > 0 then
              allowed_tag = address_filters_tag.add_element('allowed-areas')
              
              shipping.address_filters_allowed_areas.each do |area|
                self.process_area(allowed_tag, area)
              end
            end
          
            if shipping.address_filters_excluded_areas.length > 0 then
              excluded_tag = address_filters_tag.add_element('excluded-areas')
  
              shipping.address_filters_excluded_areas.each do |area|
                self.process_area(excluded_tag, area)
              end
            end
          end
        end
      end
      
      def process_pickup(parent, shipping)
        element = parent.add_element('pickup')
        element.add_attribute('name', shipping.name)
        element.add_element('price', { 'currency' => shipping.price.currency }).text = shipping.price.to_s
      end
      
      # Adds an appropriate tag for the given Area subclass instance to the parent Element.
      def process_area(parent, area)
        if area.kind_of? UsZipArea then
          parent.add_element('us-zip-area').add_element('zip-pattern').text = area.pattern
        elsif area.kind_of? UsCountryArea then
          parent.add_element('us-country-area', { 'country-area' => area.area })
        elsif area.kind_of? UsStateArea then
          parent.add_element('us-state-area').add_element('state').text = area.state
        elsif area.kind_of? WorldArea then
          parent.add_element('world-area')
        elsif area.kind_of? PostalArea then
          postal_area_element = parent.add_element('postal-area')
          postal_area_element.add_element('country-code').text = area.country_code
          if area.postal_code_pattern then
            postal_area_element.add_element('postal-code-pattern').text = area.postal_code_pattern
          end
        else
          raise "Area of unknown type: #{area.inspect}."
        end
      end
      
      # Converts a Hash into an XML structure. The keys are converted to tag names. If
      # the values are Hashs themselves then process_hash is called upon them. If the
      # values are Arrays then a new element with the key's name will be created.
      #
      # If a value is an Array then this array will be flattened before it is processed.
      # Thus, nested arrays are not allowed.
      #
      # === Example
      #
      #   process_hash(parent, { 'foo' => { 'bar' => 'baz' } })
      #   
      #   # will produce a structure that is equivalent to.
      #
      #   <foo>
      #     <bar>baz</bar>
      #   </foo>
      #
      #
      #   process_hash(parent, { 'foo' => [ { 'bar' => 'baz' }, "d'oh", 2 ] })
      #   
      #   # will produce a structure that is equivalent to.
      #
      #   <foo>
      #     <bar>baz</bar>
      #   </foo>
      #   <foo>d&amp;</foo>
      #   <foo>2</foo>
      def process_hash(parent, hash)
        hash.each do |key, value|
          if value.kind_of? Array then
            value.flatten.each do |arr_entry|
              if arr_entry.kind_of? Hash then
                self.process_hash(parent.add_element(self.str2tag_name(key.to_s)), arr_entry)
              else
                parent.add_element(self.str2tag_name(key.to_s)).text = arr_entry.to_s
              end
            end
          elsif value.kind_of? Hash then
            process_hash(parent.add_element(self.str2tag_name(key.to_s)), value)
          else
            parent.add_element(self.str2tag_name(key.to_s)).text = value.to_s
          end
        end
      end
      
      # Converts a string to a valid XML tag name. Whitespace will be converted into a dash/minus
      # sign, non alphanumeric characters that are neither "-" nor "_" nor ":" will be stripped.
      def str2tag_name(str)
        str.gsub(%r{\s}, '-').gsub(%r{[^a-zA-Z0-9\-\_:]}, '')
      end
    end

    class ChargeOrderCommandXmlGenerator < CommandXmlGenerator
      
      protected

      def process_command(command)
        root = super
        process_money(root, command.amount) if command.amount
      end

      # add the amount element to the charge command
      def process_money(parent, money)
        amount_element = parent.add_element('amount')
        amount_element.text = money.to_s
        amount_element.add_attribute('currency', money.currency)
      end
    end

    class RefundOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)
        root = super
        process_money(root, command.amount) if command.amount
        process_comment(root, command.comment) if command.comment
        process_reason(root, command.reason)
      end

      # add the amount element to the refund command
      def process_money(parent, money)
        amount_element = parent.add_element('amount')
        amount_element.text = money.to_s
        amount_element.add_attribute('currency', money.currency)
      end
      
      # add the comment element to the refund command
      def process_comment(parent, comment)
        comment_element = parent.add_element('comment')
        comment_element.text = comment
      end
      
      # add the reason element to the refund command
      def process_reason(parent, reason)
        reason_element = parent.add_element('reason')
        reason_element.text = reason
      end
    end
    
    class CancelOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)
        root = super
        root.add_element('reason').text = command.reason
        
        if command.comment then
          root.add_element('comment').text = command.comment
        end        
      end

    end

    class AuthorizeOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        super
      end
    end
 
    class ProcessOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        super
      end
    end

    class AddMerchantOrderNumberCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        root = super
        process_merchant_order_number(root, command.merchant_order_number)
      end
      
      def process_merchant_order_number(parent, merchant_order_number)
        merchant_order_number_element = parent.add_element('merchant-order-number')
        merchant_order_number_element.text = merchant_order_number
      end
    end
    
    class DeliverOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        root = super
        # Add tracking info
        process_tracking_data(root, command.carrier, command.tracking_number)
        root.add_element('send-email').text = command.send_email.to_s
      end

      def process_tracking_data(parent, carrier, tracking_number)
        if carrier and tracking_number then
          element = parent.add_element('tracking-data')
          element.add_element('carrier').text = carrier
          element.add_element('tracking-number').text = tracking_number
        end
      end
    end
    
    class AddTrackingDataCommandXmlGenerator < CommandXmlGenerator
      
      protected
      
      def process_command(command)
        root = super
        # Add tracking info
        process_tracking_data(root, command.carrier, command.tracking_number)
      end
      
      def process_tracking_data(parent, carrier, tracking_number)
        if carrier and tracking_number then
          element = parent.add_element('tracking-data')
          element.add_element('carrier').text = carrier
          element.add_element('tracking-number').text = tracking_number
        end
      end
    end
    
    class SendBuyerMessageCommandXmlGenerator < CommandXmlGenerator
      
      protected

      def process_command(command)        
        root = super
        root.add_element('message').text = command.message
        if not command.send_email.nil? then
          root.add_element('send-email').text = command.send_email.to_s
        end
      end
    end
    
    class ArchiveOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        super
      end
    end
    
    class UnarchiveOrderCommandXmlGenerator < CommandXmlGenerator

      protected

      def process_command(command)        
        super
      end
    end
    
    class MerchantCalculationResultsXmlGenerator < XmlGenerator
      
      def initialize(merchant_calculation_results)
        @merchant_calculation_results = merchant_calculation_results
      end
      
      def generate()
        super()
        process_results(@merchant_calculation_results.merchant_calculation_results)
        io = StringIO.new
        @document.write(io, 0) # TODO: Maybe replace 0 by -1 so no spaces are inserted?
        return io.string
      end
      
      protected
      
      def process_results(merchant_calculation_results)
        root = @document.add_element("merchant-calculation-results" , { 'xmlns' => 'http://checkout.google.com/schema/2' })
        results = root.add_element("results")
        for merchant_calculation_result in merchant_calculation_results do
          process_result(results, merchant_calculation_result)
        end
      end
      
      def process_result(parent, merchant_calculation_result)
        element = parent.add_element("result")
        element.add_attribute("shipping-name", merchant_calculation_result.shipping_name)
        element.add_attribute("address-id", merchant_calculation_result.address_id)
        shipping_rate = element.add_element("shipping-rate")
        shipping_rate.text = merchant_calculation_result.shipping_rate.to_s
        shipping_rate.add_attribute("currency", merchant_calculation_result.shipping_rate.currency)
        element.add_element("shippable").text = merchant_calculation_result.shippable.to_s
        if (!merchant_calculation_result.total_tax.nil?)
          total_tax = element.add_element("total-tax")
          total_tax.text = merchant_calculation_result.total_tax.to_s
          total_tax.add_attribute("currency", merchant_calculation_result.total_tax.currency)
        end
        process_code_results(element, merchant_calculation_result.merchant_code_results)
      end
      
      def process_code_results(parent, merchant_code_results)
        element = parent.add_element("merchant-code-results")
        for merchant_code_result in merchant_code_results do
          process_merchant_code_result(element, merchant_code_result)
        end
      end
      
      def process_merchant_code_result(parent, merchant_code_result)
        if merchant_code_result.kind_of?(CouponResult)
          element = parent.add_element("coupon-result")
        elsif merchant_code_result.kind_of?(GiftCertificateResult)
          element = parent.add_element("gift-certificate-result")
        else
          raise "Code of unknown type: #{merchant_code_result.inspect}."
        end
        element.add_element("valid").text = merchant_code_result.valid.to_s
        element.add_element("code").text = merchant_code_result.code.to_s
        calculated_amount = element.add_element("calculated-amount")
        calculated_amount.text = merchant_code_result.calculated_amount.to_s
        calculated_amount.add_attribute("currency", merchant_code_result.calculated_amount.currency)
        element.add_element("message").text = merchant_code_result.message
      end
    end
  end
end
