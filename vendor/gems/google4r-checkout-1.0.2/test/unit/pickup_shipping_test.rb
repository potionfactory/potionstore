#--
# Project:   google_checkout4r 
# File:      test/unit/pickup_shipping_test.rb
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

# Test for the PickupShipping class.
class Google4R::Checkout::PickupShippingMethodTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @shipping = PickupShipping.new
  end

  def test_initialization
    assert_nil @shipping.name
    assert_nil @shipping.price
  end
  
  def test_pickup_shipping_method_behaves_correctly
    [ :name, :name=, :price, :price= ].each do |sym|
      assert_respond_to @shipping, sym
    end
  end
  
  def test_pickup_shipping_method_setting_attributes_works_correctly
    @shipping.name = "Shipping Method Name"
    assert_equal "Shipping Method Name", @shipping.name
    
    @shipping.price = Money.new(100, "EUR")
    assert_kind_of Money, @shipping.price
    assert_equal 100, @shipping.price.cents
    assert_equal "EUR", @shipping.price.currency
  end
  
  def test_pickup_shipping_method_price_is_validated
    # Test that PickupShippingMethod checks for its price attribute responding
    # to cents and currency.
    assert_raises(RuntimeError) { @shipping.price = nil }
    assert_raises(RuntimeError) { @shipping.price = 10 }
    assert_raises(RuntimeError) { @shipping.price = "str" }
  end
end