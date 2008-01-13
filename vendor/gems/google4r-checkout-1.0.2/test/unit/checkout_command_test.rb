#--
# Project:   google_checkout4r 
# File:      test/unit/checkout_command_test.rb
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

# Tests for the CheckoutCommand class.
class Google4R::Checkout::CheckoutCommandTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
  end

  def test_tax_table_factory_works_correctly
    TestTaxTableFactory.any_instance.stubs(:effective_tax_tables_at).returns([:tax_table])
    
    frontend = Frontend.new(FRONTEND_CONFIGURATION)
    frontend.tax_table_factory = TestTaxTableFactory.new
    command = frontend.create_checkout_command
    
    assert_equal [:tax_table], command.tax_tables
  end
  
  def test_initialized_correctly
    assert_equal @frontend, @command.frontend
    assert_kind_of ShoppingCart, @command.shopping_cart
    assert_equal [], @command.shipping_methods
    assert_nil @command.edit_cart_url
    assert_nil @command.continue_shopping_url
    assert_nil @command.request_buyer_phone_number
  end
  
  def test_command_behaves_correctly
    [ :frontend, :shopping_cart, :tax_tables, :shipping_methods, :create_shipping_method,
      :edit_cart_url, :edit_cart_url=, :continue_shopping_url, :continue_shopping_url=,
      :request_buyer_phone_number, :request_buyer_phone_number=,
      :merchant_calculations_url, :merchant_calculations_url=,
      :accept_merchant_coupons, :accept_merchant_coupons=,
      :accept_gift_certificates, :accept_gift_certificates=,
      :platform_id, :platform_id=
    ].each do |symbol|
      assert_respond_to @command, symbol
    end
  end
  
  def test_accessors_work_correctly
    @command.edit_cart_url = "edit cart url"
    assert_equal "edit cart url", @command.edit_cart_url
    
    @command.continue_shopping_url = "continue shopping url"
    assert_equal "continue shopping url", @command.continue_shopping_url
    
    @command.request_buyer_phone_number = true
    assert_equal true, @command.request_buyer_phone_number
  end

  def test_create_shipping_method_works_correctly_with_block
    [ PickupShipping, FlatRateShipping, MerchantCalculatedShipping ].each do |clazz|
  
      shipping = nil

      res = 
        @command.create_shipping_method(clazz) do |obj|
          shipping = obj
          assert_kind_of clazz, obj
        end
    
      assert_equal res, shipping
      assert @command.shipping_methods.include?(shipping)
    end
  end
  
  def test_create_shipping_method_works_correctly_without_block
    [ PickupShipping, FlatRateShipping, MerchantCalculatedShipping ].each do |clazz|
      obj = @command.create_shipping_method(clazz)
    
      assert_kind_of clazz, obj
    
      assert @command.shipping_methods.include?(obj)
    end
  end
  
  def test_create_shipping_method_raises_exception_on_invalid_clazz_parameter
    assert_raises(ArgumentError) { @command.create_shipping_method(String) }
  end
  
  def test_to_xml_does_not_raise_exception
    assert_nothing_raised { @command.to_xml }
  end
end