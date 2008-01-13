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
# TODO: Make the optional attributes return defaults that make sense, i.e. Money.new(0)?
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
      
      # Returns a human readable representation of the Exception with the message, HTTP 
      # response code and serial number as returned by Google checkout.
      def to_s
        "GoogleCheckoutError: message = '#{@message}', response code = '#{@response_code}', serial number = '#{@serial_number}'."
      end
    end

    # ShoppingCart instances are containers for Item instances. You can add
    # Items to the class using #create_item (see the documentation of this
    # method for an example).
    class ShoppingCart
      # The owner of this cart. At the moment, this always is the CheckoutCartCommand.
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

    # An Item object represents a line of goods in the shopping cart/receipt.
    #
    # You should never initialize them directly but use ShoppingCart#create_item instead.
    #
    # Note that you have to create/set the tax tables for the owner of the cart in which
    # the item is before you can set the tax_table attribute.
    class Item
      # The cart that this item belongs to.
      attr_reader :shopping_cart
      
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
        raise "The table #{table.inspect} is not in the item's cart yet!" unless shopping_cart.owner.tax_tables.include?(table)
        
        @tax_table = table
      end
     
      # Create a new Item in the given Cart. You should not instantize this class directly
      # but use Cart#create_item instead.
      def initialize(shopping_cart)
        @shopping_cart = shopping_cart
      end

      # Creates a new Item object from a REXML::Element object.
      def self.create_from_element(element, shopping_cart)
        result = Item.new(shopping_cart)
        
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
          result.tax_table = shopping_cart.owner.tax_tables.find {|table| table.name == table_selector }
        end

        unit_price = (element.elements['unit-price'].text.to_f * 100).to_i
        unit_price_currency = element.elements['unit-price'].attributes['currency']
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

      # If shipping should be taxed with this tax rule (boolean, defaults to false)
      attr_accessor :shipping_taxed
      
      # Creates a new TaxRule in the given TaxTable. Do no call this method yourself
      # but use TaxTable#create_rule instead!
      def initialize(table)
        @table = table
        @shipping_taxed = false
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
    
    # Instances of WorldArea represent a tax area that applies globally.
    class WorldArea < Area
      def initialize
      end
    end

    # Instances of PostalArea represent a geographical region somewhere in the world.
    class PostalArea < Area
      
      # String; The two-letter ISO 3166 country code.
      attr_accessor :country_code
      
      # String; Postal code or a range of postal codes for a specific country. To specify a 
      # range of postal codes, use an asterisk as a wildcard operator. For example, 
      # you can provide a postal_code_pattern value of "SW*" to indicate that a shipping 
      # option is available or a tax rule applies in any postal code beginning with the 
      # characters SW.
      # 
      # === Example
      # 
      # area = PostalArea.new('DE')
      # area.postal_code_pattern = '10*'
      attr_accessor :postal_code_pattern
      
      # === Parameters
      #
      # country_code should be a two-letter ISO 3166 country code
      # postal_code_pattern should be a full or partial postcode string, using * as a wildcard
      def initialize(country_code, postal_code_pattern=nil)
        
        @country_code = country_code
        @postal_code_pattern = postal_code_pattern
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
    
    # Abstract class for delivery methods
    class DeliveryMethod
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
    
    # Abstract class for shipping methods. Do not use this class directly but only
    # one of its subclasses.
    class ShippingMethod < DeliveryMethod
      # An Array of allowed areas for shipping-restrictions of this shipping instance. Use 
      # #create_allowed_area to add to this area but do not change it directly.
      attr_reader :shipping_restrictions_allowed_areas
      
      # An Array of excluded areas for shipping-restrictions of this shipping instance. Use
      # #create_excluded_area to add to this area but do not change it directly.
      attr_reader :shipping_restrictions_excluded_areas
      
      def initialize
        @shipping_restrictions_allowed_areas = Array.new
        @shipping_restrictions_excluded_areas = Array.new
      end
      
      # This method create a new instance of subclass of Area and put it
      # in the array determined by the two symbols provided.  The valid
      # symbols for the first two parameters are:
      #
      # type  : :shipping_restrictions, :address_filters
      # areas : :allowed_areas, :excluded_areas
      #
      # The third parameter clazz is used to specify the type of
      # Area you want to create.  It can be one
      # of { PostalArea, UsCountryArea, UsStateArea, UsZipArea, WorldArea }.
      #
      # Raises a RuntimeError if the parameter clazz is invalid.
      #
      # If you passed a block (preferred) then the block is called
      # with the Area as the only parameter.
      #
      # === Example
      #
      #    method = MerchantCalculatedShipping.new
      #    method.create_area(:shipping_restrictions, :allowed_areas, UsCountryArea) do |area|
      #       area.area = UsCountryArea::ALL
      #    end
      def create_area(type, areas, clazz, &block)
        areas_array_name = "@#{type.to_s + '_' + areas.to_s}"
        areas = instance_variable_get(areas_array_name)
        raise "Undefined instance variable: #{areas_array_name}" unless areas.nil? == false
        raise "Invalid Area class: #{clazz}!" unless [ PostalArea, UsCountryArea, UsStateArea, UsZipArea, WorldArea ].include?(clazz)
        area = clazz.new
        areas << area

        yield(area) if block_given?
        
        return area
      end
      
      # Creates a new Area, adds it to the internal list of allowed areas for this
      # shipping type. If you passed a block (preferred) then the block is called
      # with the Area as the only parameter.
      #
      # The area to be created depends on the given parameter clazz. It can be one
      # of { PostalArea, UsCountryArea, UsStateArea, UsZipArea, WorldArea }.
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
        return create_area(:shipping_restrictions, :allowed_areas, clazz, &block)
      end
      
      # Creates a new Area, adds it to the internal list of excluded areas for shipping
      # restrictions. If you passed a block (preferred) then the block is called
      # with the Area as the only parameter. The created area is returned in any case.
      #
      # The area to be created depends on the given parameter clazz. It can be one
      # of { PostalArea, UsCountryArea, UsStateArea, UsZipArea, WorldArea }.
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
        return create_area(:shipping_restrictions, :excluded_areas, clazz, &block)
      end      
    end
    
    # A class that represents the "pickup" shipping method.
    class PickupShipping < DeliveryMethod
      def initialize
      end
    end
    
    # A class that represents the "flat_rate" shipping method.
    class FlatRateShipping < ShippingMethod
      def initialize
        super
      end
    end
    
    # A class that represents the "merchant-calculated" shipping method
    class MerchantCalculatedShipping < ShippingMethod
      
      # An Array of allowed areas for address-filters of this shipping instance. Use 
      # #create_allowed_area to add to this area but do not change it directly.
      attr_reader :address_filters_allowed_areas
      
      # An Array of excluded areas for address-filters of this shipping instance. Use
      # #create_excluded_area to add to this area but do not change it directly.
      attr_reader :address_filters_excluded_areas
      
      def initialize
        super
        @address_filters_allowed_areas = Array.new
        @address_filters_excluded_areas = Array.new
      end
      
    end
    
    # This address is used in merchant calculation callback
    class AnonymousAddress
      
      # The address ID (String)
      attr_accessor :address_id
      
      # The buyer's city name (String).
      attr_accessor :city
      
      # The buyers postal/zip code (String).
      attr_accessor :postal_code
      
      # The buyer's geographical region (String).
      attr_accessor :region
      
      # The buyer's country code (String, 2 chars, ISO 3166).
      attr_accessor :country_code
      
      # Creates a new AnonymousAddress from the given REXML::Element instance.
      def self.create_from_element(element)
        result = AnonymousAddress.new
        
        result.address_id = element.attributes['id']
        result.city = element.elements['city'].text
        result.country_code = element.elements['country-code'].text
        result.postal_code = element.elements['postal-code'].text
        result.region = element.elements['region'].text
        return result
      end
    end

    # Address instances are used in NewOrderNotification objects for the buyer's billing
    # and buyer's shipping address.
    class Address < AnonymousAddress
      # Contact name (String, optional).
      attr_accessor :contact_name
      
      # Second Address line (String).
      attr_accessor :address1

      # Second Address line (String optional).
      attr_accessor :address2
      
      # The buyer's city name (String).
      # attr_accessor :city
      # Now inherit from AnonymousAddress
      
      # The buyer's company name (String; optional).
      attr_accessor :company_name
      
      # The buyer's country code (String, 2 chars, ISO 3166).
      # attr_accessor :country_code
      # Now inherit from AnonymousAddress
      
      # The buyer's email address (String; optional).
      attr_accessor :email
      
      # The buyer's phone number (String; optional).
      attr_accessor :fax
      
      # The buyer's phone number (String; Optional, can be enforced in CheckoutCommand).)
      attr_accessor :phone
      
      # The buyers postal/zip code (String).
      # attr_accessor :postal_code
      # Now inherit from AnonymousAddress
      
      
      # The buyer's geographical region (String).
      # attr_accessor :region
      # Now inherit from AnonymousAddress
      
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
  end
end
