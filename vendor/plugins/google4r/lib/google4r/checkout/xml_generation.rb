#--
# Project:   google4r
# File:      lib/google4r/checkout/xml_generation.rb
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
# This file contains the classes that allow to persist the object hierarchies
# that are created with the Google Checkout API to XML.

require 'stringio'
require 'rexml/document'

module Google4R #:nodoc:
  module Checkout #:nodoc:
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
    # TODO
    #
    # * Refactor the big, monolitic generator into smaller, easier testable ones. One
    #   for each major part of the resulting XML document. This will also reduce the
    #   overhead in generating other types of XML documents.
    #++
    class CheckoutCommandXmlGenerator
      # Initializes the CheckoutCommandXmlGenerator with the CheckoutCommand it is
      # to conver to XML.
      def initialize(checkout_command)
        @checkout_command = checkout_command
      end
      
      # Creates an XML document from the checkout_command passed into the constructor. Returns
      # the resulting XML string.
      def generate
        @document = REXML::Document.new
        
        declaration = REXML::XMLDecl.new
        declaration.encoding = 'utf-8'
        @document << declaration
        
        self.process_checkout_command(@checkout_command)
        
        io = StringIO.new
        @document.write(io, 0) # TODO: Maybe replace 0 by -1 so no spaces are inserted?
        return io.string
      end
      
      protected
      
        def process_checkout_command(command)
          root = @document.add_element('checkout-shopping-cart', { 'xmlns' => 'http://checkout.google.com/schema/2' })
          
          self.process_shopping_cart(root, command.cart)
          
          # <merchant-checkout-flow-support>
          flow_element = root.add_element('checkout-flow-support').add_element('merchant-checkout-flow-support')

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
          
          # <tax-tables>
          command.tax_tables.each do |tax_table|
          end
          
          # <shipping-methods>
          shippings_element = flow_element.add_element('shipping-methods')
          command.shipping_methods.each do |shipping_method|
            self.process_shipping_method(shippings_element, shipping_method)
          end
        end
        
        def process_shopping_cart(parent, cart)
          cart_element = parent.add_element('shopping-cart')
          
          # add <cart-expiration> tag to the cart if a time has been added to the cart
          if not cart.expires_at.nil? then
            cart_element.add_element('cart-expiration').add_element('good-until-date').text =
              cart.expires_at.iso8601
          end
          
          # add <merchant-private-data> to the cart if any has been set
          if not cart.private_data.nil? then
            self.process_hash(cart_element.add_element('merchant-private-data'), cart.private_data)
          end
          
          # process the items in the cart
          items_element = cart_element.add_element('items')
          cart.items.each do |item|
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
            process_pickup_shipping(parent, shipping_method)
          elsif shipping_method.kind_of? FlatRateShipping then
            process_flat_rate_shipping(parent, shipping_method)
          else
            raise "Unknown ShippingMethod type of #{shipping_method.inspect}!"
          end
        end
        
        def process_flat_rate_shipping(parent, shipping)
          element = parent.add_element('flat-rate-shipping')
          element.add_attribute('name', shipping.name)
          element.add_element('price', { 'currency' => shipping.price.currency }).text = shipping.price.to_s
          
          if shipping.excluded_areas.length + shipping.allowed_areas.length > 0 then
            restrictions_tag = element.add_element('shipping-restrictions')
            
            if shipping.allowed_areas.length > 0 then
              allowed_tag = restrictions_tag.add_element('allowed-areas')
              
              shipping.allowed_areas.each do |area|
                self.process_area(allowed_tag, area)
              end
            end
          
            if shipping.excluded_areas.length > 0 then
              excluded_tag = restrictions_tag.add_element('excluded-areas')

              shipping.excluded_areas.each do |area|
                self.process_area(excluded_tag, area)
              end
            end
          end
        end
        
        def process_pickup_shipping(parent, shipping)
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
              parent.add_element(self.str2tag_name(key.to_s))
            end
          end
        end
        
        # Converts a string to a valid XML tag name. Whitespace will be converted into a dash/minus
        # sign, non alphanumeric characters that are neither "-" nor "_" nor ":" will be stripped.
        def str2tag_name(str)
          str.gsub(%r{\s}, '-').gsub(%r{[^a-zA-Z0-9\-\_:]}, '')
        end
    end
  end
end
