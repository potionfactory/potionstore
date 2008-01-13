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

# Test for the Item class.
class Google4R::Checkout::ItemTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <item>
        <item-name>MegaSound 2GB MP3 Player</item-name>
        <item-description>Portable MP3 player - stores 500 songs</item-description>
        <unit-price currency="USD">178.00</unit-price>
        <quantity>1</quantity>
        <merchant-item-id>MGS2GBMP3</merchant-item-id>
        <merchant-private-item-data>
          <item-note>Text 1</item-note>
          <item-note>Text 2</item-note>
          <nested>
            <tags>value</tags>
          </nested>
        </merchant-private-item-data>
        <tax-table-selector>Some Table</tax-table-selector>
      </item>}
    
    @optional_tags = [ 'merchant-item-id', 'merchant-private-item-data', 'tax-table-selector' ]

    @command = @frontend.create_checkout_command
    @shopping_cart = @command.shopping_cart
    @item = @shopping_cart.create_item
  end
  
  def test_item_behaves_correctly
    [ :shopping_cart,  :name, :name=, :description, :description=, :unit_price, :unit_price=,
      :quantity, :quantity=, :id, :id=, :private_data, :private_data=,
      :tax_table, :tax_table=
    ].each do |symbol|
      assert_respond_to @item, symbol
    end
  end
  
  def test_item_gets_initialized_correctly
    assert_equal @shopping_cart, @item.shopping_cart
    assert_nil @item.name
    assert_nil @item.description
    assert_nil @item.unit_price
    assert_nil @item.quantity
    assert_nil @item.private_data
    assert_nil @item.id
    assert_nil @item.tax_table
  end
  
  def test_item_setters_work
    @item.name = "name"
    assert_equal "name", @item.name
    
    @item.description = "description"
    assert_equal "description", @item.description
    
    @item.unit_price = Money.new(100, "EUR")
    assert_equal Money.new(100, "EUR"), @item.unit_price
    
    @item.quantity = 10
    assert_equal 10, @item.quantity
    
    @item.id = "id"
    assert_equal "id", @item.id
    
    @item.private_data = Hash.new
    assert_equal Hash.new, @item.private_data
  end
  
  def test_set_tax_table_works
    table = @command.tax_tables.first
    @item.tax_table = table
    assert_equal table, @item.tax_table
  end
  
  def test_set_tax_table_raises_if_table_is_unknown_in_command
    assert_raises(RuntimeError) { @item.tax_table = TaxTable.new(false) }
  end
  
  def test_set_private_data_only_works_with_hashes
    assert_raises(RuntimeError) { @shopping_cart.private_data = 1 }
    assert_raises(RuntimeError) { @shopping_cart.private_data = nil }
    assert_raises(RuntimeError) { @shopping_cart.private_data = 'Foobar' }
    assert_raises(RuntimeError) { @shopping_cart.private_data = [] }
  end
  
  def test_item_price_must_be_money_instance
    assert_raises(RuntimeError) { @item.unit_price = nil }
    assert_raises(RuntimeError) { @item.unit_price = "String" }
    assert_raises(RuntimeError) { @item.unit_price = 10 }
  end

  def test_create_from_element_works
    @optional_tags.power.each do |optional_tag_names|
      xml_str = @xml_str

      optional_tag_names.each { |name| xml_str = xml_str.gsub(%r{<#{name}.*?</#{name}>}, '') }

      command = @frontend.create_checkout_command
      tax_table = TaxTable.new(false)
      tax_table.name = 'Some Table'
      command.tax_tables << tax_table
      item = Item.create_from_element(REXML::Document.new(xml_str).root, command.shopping_cart)
      
      assert_equal command.shopping_cart, item.shopping_cart
      
      assert_equal 'MegaSound 2GB MP3 Player', item.name
      assert_equal 'Portable MP3 player - stores 500 songs', item.description
      assert_equal Money.new(17800, 'USD'), item.unit_price
      assert_equal 1, item.quantity
      assert_equal 'MGS2GBMP3', item.id unless item.id.nil?
      
      hash = 
        {
          'item-note' => [ 'Text 1', 'Text 2' ],
          'nested' => { 'tags' => 'value' }
        }
      assert_equal hash, item.private_data unless optional_tag_names.include?('merchant-private-item-data')

      assert_equal 'Some Table', item.tax_table.name unless optional_tag_names.include?('tax-table-selector')
    end
  end
end