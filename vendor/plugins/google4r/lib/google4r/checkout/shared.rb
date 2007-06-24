#--
# Project:   google4r
# File:      lib/google4r/checkout/shared.rb 
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
# This file contains the classes and modules that are shared by the notification
# handling and parsing as well as the command generating code.

#--
# TODO
#
#  * Make the optional attributes return defaults that make sense, i.e. Money.new(0)
#  * Make the "main" API really pretty Ruby code and provide aliases so people can
#    also just use the Google Docs.
#++
module Google4R #:nodoc:
  module Checkout #:nodoc:
    # This exception is thrown by Command#send_to_google_checkout when an error occured.
    class GoogleCheckoutError < Exception
      # The serial number of the error returned by Google.
      attr_reader :serial_number
      
      # The HTTP response code of Google's response.
      attr_reader :response_code
      
      # The parameter is a hash with the entries :serial_number, :message and :response_code. 
      # The attributes serial_number, message and response_code are set to the values in the 
      # Hash.
      def initialize(hash)
        @response_code = hash[:response_code]
        @message = hash[:message]
        @serial_number = hash[:serial_number]
      end
    end

    # ShoppingCart instances are containers for Item instances. You can add
    # Items to the class using #create_item (see the documentation of this
    # method for an example).
    class ShoppingCart
      # The onwer of this cart. At the moment, this always is the CheckoutCartCommand.
      attr_reader :owner
      
      # The items in the cart. Do not modify this array directly but use
      # #create_item to add items.
      attr_reader :items
      
      # You can set the <cart-expiration> time with this property. If left
      # unset then the tag will not be generated and the cart will never
      # expire.
      attr_accessor :expires_at
      
      # You can set almost arbitrary data into the cart using this method.
      #
      # The data will be converted to XML in the following way: The keys are converted
      # to tag names (whitespace becomes "-", all chars not matching /[a-zA-Z0-9\-_])/
      # will be removed.
      #
      # If a value is an array then the key for this value will be used as the tag
      # name for each of the arrays's entries.
      #
      # Arrays will be flattened before it is processed.
      #
      # === Example
      #
      #   cart.private_data = { 'foo' => { 'bar' => 'baz' } })
      #   
      #   # will produce the following XML
      #
      #   <foo>
      #     <bar>baz</bar>
      #   </foo>
      #
      #
      #   cart.private_data = { 'foo' => [ { 'bar' => 'baz' }, "d'oh", 2 ] }
      #   
      #   # will produce the following XML
      #
      #   <foo>
      #     <bar>baz</bar>
      #   </foo>
      #   <foo>d&amp;</foo>
      #   <foo>2</foo>
      attr_reader :private_data
      
      # Sets the value of the private_data attribute.
      def private_data=(value)
        raise "The given value #{value.inspect} is not a Hash!" unless value.kind_of?(Hash)
        @private_data = value
      end
      
      # Initialize a new ShoppingCart with an empty Array for the items.
      def initialize(owner)
        @owner = owner
        @items = Array.new
      end
      
      # Use this method to add a new item to the cart. If you use a block with
      # this method then the block will be given the new item. The new item 
      # will be returned in any case.
      #
      # Passing a block is the preferred way of using this method.
      #
      # === Example
      #
      #   # Using a block (preferred).
      #   cart = ShoppingCart.new
      #   
      #   cart.create_item do |item|
      #     item.name = "Dry Food Pack"
      #     item.description = "A pack of highly nutritious..."
      #     item.unit_price = Money.new(3500, "USD") # $35.00
      #     item.quantity = 1
      #   end
      #   
      #   # Not using a block.
      #   cart = ShoppingCart.new
      #   
      #   item = cart.create_item
      #   item.name = "Dry Food Pack"
      #   item.description = "A pack of highly nutritious..."
      #   item.unit_price = Money.new(3500, "USD") # $35.00
      #   item.quantity = 1
      def create_item(&block)
        item = Item.new(self)
        @items << item

        # Pass the newly generated item to the given block to set its attributes.
        yield(item) if block_given?
        
        return item
      end

      # Creates a new ShoppingCart object from a REXML::Element object.
      def self.create_from_element(element, owner)
        result = ShoppingCart.new(owner)
        
        text = element.elements['cart-expiration/good-until-date'].text rescue nil
        result.expires_at = Time.parse(text) unless text.nil?
        
        data_element = element.elements['merchant-private-data']
        value = PrivateDataParser.element_to_value(data_element) unless data_element.nil?
        
        result.private_data = value unless value.nil?
        
        element.elements.each('items/item') do |item_element|
          result.items << Item.create_from_element(item_element, result)
        end
        
        return result
      end
    end

    # An Item object represents a line of goods in the shopping cart/reciep.
    #
    # You should never initialize them directly but use ShoppingCart#create_item instead.
    #
    # Note that you have to create/set the tax tables for the owner of the cart in which
    # the item is before you can set the tax_table attribute.
    class Item
      # The cart that this item belongs to.
      attr_reader :cart
      
      # The name of the cart item (string, required).
      attr_accessor :name
      
      # The description of the cart item (string, required).
      attr_accessor :description
      
      # The price for one unit of the given good (Money instance, required).
      attr_reader :unit_price

      # Sets the price for one unit of goods described by this item. money must respond to
      # :cents and :currency as the Money class does.
      def unit_price=(money)
        if not (money.respond_to?(:cents) and money.respond_to?(:currency)) then
          raise "Invalid price - does not respond to :cents and :currency - #{money.inspect}."
        end
        
        @unit_price = money
      end
      
      # Number of units that this item represents (integer, required).
      attr_accessor :quantity
      
      # Optional string value that is used to store the item's id (defined by the merchant) 
      # in the cart. Serialized to <merchant-item-id> in XML. Displayed by Google Checkout.
      attr_accessor :id
      
      # Optional hash value that is used to store the item's id (defined by the merchant) 
      # in the cart. Serialized to <merchant-private-item-data> in XML. Not displayed by
      # Google Checkout.
      #
      # Must be a Hash. See ShoppingCart#private_data on how the serialization to XML is
      # done.
      attr_reader :private_data

      # Sets the private data for this item. 
      def private_data=(value)
        raise "The given value #{value.inspect} is not a Hash!" unless value.kind_of?(Hash)
        @private_data = value
      end
      
      # The tax table to use for this item. Optional.
      attr_reader :tax_table
      
      # Sets the tax table to use for this item. When you set this attribute using this
      # method then the used table must already be added to the cart. Otherwise, a 
      # RuntimeError will be raised.
      def tax_table=(table)
        raise "The table #{table.inspect} is not in the item's cart yet!" unless cart.owner.tax_tables.include?(table)
        
        @tax_table = table
      end
     
      # Create a new Item in the given Cart. You should not instantize this class directly
      # but use Cart#create_item instead.
      def initialize(cart)
        @cart = cart
      end

      # Creates a new Item object from a REXML::Element object.
      def self.create_from_element(element, cart)
        result = Item.new(cart)
        
        result.name = element.elements['item-name'].text
        result.description = element.elements['item-description'].text
        result.quantity = element.elements['quantity'].text.to_i
        result.id = element.elements['merchant-item-id'].text rescue nil

        data_element = element.elements['merchant-private-item-data']
        if not data_element.nil? then
          value = PrivateDataParser.element_to_value(data_element)
          result.private_data = value unless value.nil?
        end
        
        table_selector = element.elements['tax-table-selector'].text rescue nil
        if not table_selector.nil? then
          result.tax_table = cart.owner.tax_tables.find {|table| table.name == table_selector }
        end

        unit_price = (element.elements['unit-price'].text.to_f * 100).to_i
        unit_price_currency = element.elements['unit-price/@currency'].value
        result.unit_price = Money.new(unit_price, unit_price_currency)
        
        return result
      end
    end
    
    # A TaxTable is an ordered array of TaxRule objects. You should create the TaxRule
    # instances using #create_rule
    #
    # You must set up a tax table factory and should only create tax tables from within
    # its temporal factory method as described in the class documentation of Frontend.
    #
    # Each tax table must have one or more tax rules.
    #
    # === Example
    #
    #   include Google4R::Checkout
    #
    #   tax_free_table = TaxTable.new(false)
    #   tax_free_table.name = "default table"
    #   tax_free_table.create_rule do |rule|
    #     rule.area = UsCountryArea.new(UsCountryArea::ALL)
    #     rule.rate = 0.0
    #   end
    class TaxTable
      # The name of this tax table (string, required).
      attr_accessor :name
      
      # An Array of the TaxRule objects that this TaxTable contains. Use #create_rule do
      # add to this Array but do not change it directly.
      attr_reader :rules
      
      # Boolean, true iff the table's standalone attribute is to be set to "true".
      attr_reader :standalone
      
      def initialize(standalone)
        @rules = Array.new
        
        @standalone = standalone
      end
      
      # Use this method to add a new TaxRule to the table. If you use a block with
      # this method then the block will called with the newly created rule for the
      # parameter. The method will return the new rule in any case.
      def create_rule(&block)
        rule = TaxRule.new(self)
        @rules << rule
        
        # Pass the newly generated rule to the given block to set its attributes.
        yield(rule) if block_given?
        
        return rule
      end
    end
    
    # A TaxRule specifies which taxes to apply in which area. Have a look at the "Google
    # Checkout documentation" [http://code.google.com/apis/checkout/developer/index.html#specifying_tax_info]
    # for more information.
    class TaxRule
      # The table this rule belongs to.
      attr_reader :table
      
      # The tax rate for this rule (double, required).
      attr_accessor :rate
      
      # The area where this tax rule applies (Area subclass instance, required). Serialized
      # to <tax-area> in XML.
      attr_accessor :area
      
      # Creates a new TaxRule in the given TaxTable. Do no call this method yourself
      # but use TaxTable#create_rule instead!
      def initialize(table)
        @table = table
      end
    end
    
    # Abstract class for areas that are used to specify a tax area. Do not use this class
    # but only its subclasses.
    class Area
      # Mark this class as abstract by throwing a RuntimeError on initialization.
      def initialize #:nodoc:
        raise "Do not use the abstract class Google::Checkout::Area!"
      end
    end

    # Instances of UsZipArea represent areas specified by US ZIPs and ZIP patterns.
    class UsZipArea < Area
      # The pattern for this ZIP area.
      attr_accessor :pattern
      
      # You can optionally initialize the Area with its value.
      def initialize(pattern=nil)
        self.pattern = pattern unless pattern.nil?
      end
    end
    
    # Instances of UsStateArea represent states in the US. 
    class UsStateArea < Area
      # The two-letter code of the US state.
      attr_reader :state
      
      # You can optionally initialize the Area with its value.
      def initialize(state=nil)
        self.state = state unless state.nil?
      end
      
      # Writer for the state attribute. value must match /^[A-Z]{2,2}$/.
      def state=(value)
        raise "Invalid US state: #{value}" unless value =~ /^[A-Z]{2,2}$/
        @state = value
      end
    end
    
    # Instances of UsCountryArea identify a region within the US.
    class UsCountryArea < Area
      CONTINENTAL_48 = "CONTINENTAL_48".freeze
      FULL_50_STATES = "FULL_50_STATES".freeze
      ALL = "ALL".freeze
      
      # The area that is specified with this UsCountryArea (required). Can be
      # one of UsCountryArea::CONTINENTAL_48, UsCountryArea::FULL_50_STATES
      # and UsCountryArea::ALL.
      # See the Google Checkout API for information on these values.
      attr_reader :area

      # You can optionally initialize the Area with its value.
      def initialize(area=nil)
        self.area = area unless area.nil?
      end

      # Writer for the area attribute. value must be one of CONTINENTAL_48, 
      # FULL_50_STATES and ALL
      def area=(value)
        raise "Invalid area :#{value}!" unless [ CONTINENTAL_48, FULL_50_STATES, ALL ].include?(value)
        @area = value
      end
    end
    
    # Abstract class for shipping methods. Do not use this class directly but only
    # one of its subclasses.
    class ShippingMethod
      # The name of the shipping method (string, required).
      attr_accessor :name
      
      # The price of the shipping method (Money instance, required).
      attr_reader :price
      
      # Sets the cost for this shipping method. money must respond to :cents and :currency
      # as Money objects would.
      def price=(money)
        if not (money.respond_to?(:cents) and money.respond_to?(:currency)) then
          raise "Invalid cost - does not respond to :cents and :currency - #{money.inspect}."
        end
        
        @price = money
      end
      
      # Mark this class as abstract by throwing a RuntimeError on initialization.
      def initialize
        raise "Do not use the abstract class Google::Checkout::ShippingMethod!"
      end
    end
    
    # A class that represents the "pickup" shipping method.
    class PickupShipping < ShippingMethod
      def initialize
      end
    end
    
    # A class that represents the "flat_rate" shipping method.
    class FlatRateShipping < ShippingMethod
      # An Array of allowed areas for this flat_rate shipping instance. Use 
      # #create_allowed_area to add to this area but do not change it directly.
      attr_reader :allowed_areas
      
      # An Array of excluded areas for this flat_rate shipping instance. Use
      # #create_excluded_area to add to this area but do not change it directly.
      attr_reader :excluded_areas
      
      def initialize
        @allowed_areas = Array.new
        @excluded_areas = Array.new
      end
      
      # Creates a new Area, adds it to the internal list of allowed areas for this
      # shipping types. If you passed a block (preferred) then the block is called
      # with the Area as the only parameter.c
      #
      # The area to be created depends on the given parameter clazz. It can be one
      # of { UsCountryArea, UsStateArea, UsZipArea }.
      #
      # Raises a RuntimeError if the parameter clazz is invalid.
      #
      # === Example
      #
      #    method = FlatRateShipping.new
      #    method.create_allowed_area(UsCountryArea) do |area|
      #       area.area = UsCountryArea::ALL
      #    end
      def create_allowed_area(clazz, &block)
        raise "Invalid Area class: #{clazz}!" unless [ UsCountryArea, UsStateArea, UsZipArea ].include?(clazz)
        
        area = clazz.new
        @allowed_areas << area

        yield(area) if block_given?
        
        return area
      end
      
      # Creates a new Area, adds it to the internal list of excluded areas for this
      # shipping types. If you passed a block (preferred) then the block is called
      # with the Area as the only parameter. The created area is returned in any case.
      #
      # The area to be created depends on the given parameter clazz. It can be one
      # of { UsCountryArea, UsStateArea, UsZipArea }.
      #
      # Raises a RuntimeError if the parameter clazz is invalid.
      #
      # === Example
      #
      #    method = FlatRateShipping.new
      #    method.create_excluded_area(UsCountryArea) do |area|
      #       area.area = UsCountryArea::ALL
      #    end
      def create_excluded_area(clazz, &block)
        raise "Invalid Area class: #{clazz}!" unless [ UsCountryArea, UsStateArea, UsZipArea ].include?(clazz)

        area = clazz.new
        @excluded_areas << area
        
        yield(area) if block_given?
        
        return area
      end
    end
  end
end
