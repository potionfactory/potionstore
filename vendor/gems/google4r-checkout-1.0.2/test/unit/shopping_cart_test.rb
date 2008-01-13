#--
# Project:   google_checkout4r 
# File:      test/unit/area_test.rb
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

require File.expand_path(File.dirname(__FILE__)) + '/../test_helper'

require 'google4r/checkout'

require 'test/frontend_configuration'

# Tests for the ShoppingCart class and all subclasses.
class Google4R::Checkout::ShoppingCartTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
    @shopping_cart = @command.shopping_cart
    
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <shopping-cart>
        <merchant-private-data>
          <affiliate-code>01234</affiliate-code>
        </merchant-private-data>
        <cart-expiration>
          <good-until-date>2007-12-31T23:59:59-05:00</good-until-date>
        </cart-expiration>
        <items>
          <item>
            <item-name>AA Rechargeable Battery Pack</item-name>
            <item-description>Battery pack containing four AA rechargeable batteries</item-description>
            <unit-price currency="USD">12.00</unit-price>
            <quantity>1</quantity>
          </item>
          <item>
            <item-name>MegaSound 2GB MP3 Player</item-name>
            <item-description>Portable MP3 player - stores 500 songs</item-description>
            <quantity>1</quantity>
            <unit-price currency="USD">178.00</unit-price>
          </item>
        </items>
      </shopping-cart>}

    @optional_tags = [ 'cart-expiration', 'merchant-private-data' ]
  end
  
  def test_behaves_correctly
    [ :owner, :expires_at, :items, :owner, :private_data, :private_data= ].each do |sym|
      assert_respond_to @shopping_cart, sym
    end
  end
  
  def test_initialized_correctly
    assert_equal @command, @shopping_cart.owner
    assert_equal nil, @shopping_cart.expires_at
    assert_equal [], @shopping_cart.items
    assert_equal @command, @shopping_cart.owner
  end
  
  def test_accessors_work_correctly
    hash = { 'foo' => [ { 'bar' => 'baz' }, "d'oh", 2 ] }
    @shopping_cart.private_data = hash.dup
    assert_equal hash, @shopping_cart.private_data
  end

  def test_setting_private_data_only_works_with_a_hash
    assert_raises(RuntimeError) { @shopping_cart.private_data = 1 }
    assert_raises(RuntimeError) { @shopping_cart.private_data = nil }
    assert_raises(RuntimeError) { @shopping_cart.private_data = 'Foobar' }
    assert_raises(RuntimeError) { @shopping_cart.private_data = [] }
  end
  
  def test_create_item_works_correctly_with_block
    the_item = nil
    
    res = 
      @shopping_cart.create_item do |item|
        the_item = item
      
        assert_kind_of Item, item
      end
    
    assert_equal res, the_item
    assert @shopping_cart.items.include?(the_item)
  end
  
  def test_create_item_works_correctly_without_block
    item = @shopping_cart.create_item
    
    assert @shopping_cart.items.include?(item)
  end
  
  def test_create_from_element_works
    @optional_tags.power.each do |optional_tag_names|
      xml_str = @xml_str

      optional_tag_names.each { |name| xml_str = xml_str.gsub(%r{<#{name}.*?</#{name}>}, '') }

      element = REXML::Document.new(xml_str).root
    
      expect = Item.stubs(:create_from_element)
      expect.with do |element, shopping_cart| 
        element.name == 'item' and
        element.elements['item-name'].text == 'AA Rechargeable Battery Pack'
      end
      expect.times(1).returns(:item1)

      expect = Item.stubs(:create_from_element)
      expect.with do |element, shopping_cart|
        element.name == 'item' and
        element.elements['item-name'].text == 'MegaSound 2GB MP3 Player'
      end
      expect.times(1).returns(:item2)

      shopping_cart = ShoppingCart.create_from_element(element, nil)
    
      assert_equal Time.parse("2007-12-31T23:59:59-05:00"), shopping_cart.expires_at unless optional_tag_names.include?('cart-expiration')
      assert_equal [ :item1, :item2 ], shopping_cart.items
      assert_equal({ 'affiliate-code' => '01234' }, shopping_cart.private_data) unless optional_tag_names.include?('merchant-private-data')
    end
  end
end