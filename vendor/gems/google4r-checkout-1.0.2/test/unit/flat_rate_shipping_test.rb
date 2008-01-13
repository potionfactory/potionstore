#--
# Project:   google_checkout4r 
# File:      test/unit/flat_rate_shipping_test.rb
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

require File.expand_path(File.dirname(__FILE__)) + '/../test_helper'

require 'google4r/checkout'

require 'test/frontend_configuration'

# Test for the FlatRateShipping class.
class Google4R::Checkout::FlatRateShippingMethodTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @shipping = FlatRateShipping.new
  end
  
  def test_flat_rate_shipping_method_behaves_correctly
    [ :name, :name=, :price, :price=, 
      :shipping_restrictions_allowed_areas, :shipping_restrictions_excluded_areas,
      :create_allowed_area, :create_excluded_area, :create_area
    ].each do |symbol|
      assert_respond_to @shipping, symbol
    end
  end
  
  def test_initialization
    assert_nil @shipping.name
    assert_nil @shipping.price
    assert_equal [], @shipping.shipping_restrictions_allowed_areas
    assert_equal [], @shipping.shipping_restrictions_excluded_areas
  end
  
  def test_flat_rate_shipping_method_setting_attributes_works_correctly
    @shipping.name = "Shipping Method Name"
    assert_equal "Shipping Method Name", @shipping.name
    
    @shipping.price = Money.new(100, "EUR")
    assert_kind_of Money, @shipping.price
    assert_equal 100, @shipping.price.cents
    assert_equal "EUR", @shipping.price.currency
  end
  
  def test_flat_rate_shipping_method_price_is_validated
    # Test that FlatRateShippingMethod checks for its price attribute responding
    # to cents and currency.
    assert_raises(RuntimeError) { @shipping.price = nil }
    assert_raises(RuntimeError) { @shipping.price = 10 }
    assert_raises(RuntimeError) { @shipping.price = "str" }
  end
  
  def test_create_allowed_excluded_areas_works_with_block
    [ [ :shipping_restrictions_allowed_areas, :create_allowed_area], 
      [ :shipping_restrictions_excluded_areas, :create_excluded_area ] ].each do |pair|
      read_sym, create_sym = pair
      
      [ UsZipArea, UsStateArea, UsCountryArea ].each do |clazz|
    
        the_area = nil
    
        res = 
          @shipping.send(create_sym, clazz) do |area|
            the_area = area
            assert_kind_of clazz, area
          end
      
        assert_equal res, the_area
        assert @shipping.send(read_sym).include?(the_area)
      end
    end
  end

  def test_create_allowed_excluded_areas_works_without_block
    [ [ :shipping_restrictions_allowed_areas, :create_allowed_area], 
      [ :shipping_restrictions_excluded_areas, :create_excluded_area ] ].each do |pair|
      read_sym, create_sym = pair

      [ UsZipArea, UsStateArea, UsCountryArea ].each do |clazz|
        area = @shipping.send(create_sym, clazz)
      
        assert_kind_of clazz, area
      
        assert @shipping.send(read_sym).include?(area)
      end
    end
  end

  def test_create_allowed_excluded_areas_validates_parameter
    [ :create_allowed_area, :create_excluded_area ].each do |sym|
      assert_raises(RuntimeError) { @shipping.send(sym, String) }
    end
  end
  
  def test_new_create_area_with_flat_rate_shipping
    [ [ :shipping_restrictions, :allowed_areas ],
      [ :shipping_restrictions, :excluded_areas ] ].each do |pair|
        type_sym, area_sym = pair
        [ UsZipArea, UsStateArea, UsCountryArea ].each do |clazz|
        area = @shipping.send(:create_area, type_sym, area_sym, clazz)
      
        assert_kind_of clazz, area
      
        assert @shipping.send((type_sym.to_s + '_' + area_sym.to_s).to_sym).include?(area)
      end
    end
  end
end