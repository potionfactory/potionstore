#--
# Project:   google_checkout4r 
# File:      test/unit/order_adjustment_test.rb
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

# Test for the class OrderAdjustment.
class Google4R::Checkout::OrderAdjustmentTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <order-adjustment>
        <merchant-calculation-successful>true</merchant-calculation-successful>
        <merchant-codes>
          <dummy-adjustment-one />
          <dummy-adjustment-two />
        </merchant-codes>
        <total-tax currency="USD">11.05</total-tax>
        <adjustment-total currency="USD">12.05</adjustment-total>
        <shipping>
          <%s />
        </shipping>
      </order-adjustment>}
    @shipping_adjustments = [ 'flat-rate-shipping-adjustment', 'pickup-shipping-adjustment' ]
  end
  
  def test_reponds_correctly
    assert_respond_to OrderAdjustment, :create_from_element

    adjustment = OrderAdjustment.new
    
    [ :adjustment_total, :adjustment_total=, :merchant_calculation_successful,
      :merchant_calculation_successful, :merchant_codes, :merchant_codes=, 
      :shipping, :shipping=, :total_tax, :total_tax=
    ].each do |symbol|
      assert_respond_to adjustment, symbol
    end
  end
  
  def test_create_from_xml_works_correctly
    @shipping_adjustments.each do |adjustment_name|
      # Build Mocha Expectations
      expect = MerchantCode.stubs(:create_from_element)
      expect.with { |element| element.name == 'dummy-adjustment-one' }
      expect.times(1).returns(:dummy_adjustment1)

      expect = MerchantCode.stubs(:create_from_element)
      expect.with { |element| element.name == 'dummy-adjustment-two' }
      expect.times(1).returns(:dummy_adjustment2)
      
      expect = ShippingAdjustment.stubs(:create_from_element)
      expect.with { |element| element.name == adjustment_name }
      expect.times(1).returns(adjustment_name.to_sym)
    
      # Create the adjustment
      element = REXML::Document.new(@xml_str % [ adjustment_name ]).root
      adjustment = OrderAdjustment.create_from_element(element)
    
      # Assert!
      assert_equal Money.new(1205, 'USD'), adjustment.adjustment_total
      assert_equal true, adjustment.merchant_calculation_successful
      assert_equal [ :dummy_adjustment1, :dummy_adjustment2 ], adjustment.merchant_codes
      assert_equal adjustment_name.to_sym, adjustment.shipping
      assert_equal Money.new(1105, 'USD'), adjustment.total_tax
    end
  end
  
  def test_create_from_xml_works_correctly_without_shiping_tag
    # Build Mocha Expectations
    expect = MerchantCode.stubs(:create_from_element)
    expect.with { |element| element.name == 'dummy-adjustment-one' }
    expect.times(1).returns(:dummy_adjustment1)

    expect = MerchantCode.stubs(:create_from_element)
    expect.with { |element| element.name == 'dummy-adjustment-two' }
    expect.times(1).returns(:dummy_adjustment2)
    
    expect = ShippingAdjustment.expects(:create_from_element).never
  
    # Create the adjustment
    element = REXML::Document.new(@xml_str.gsub(%r{<shipping>.*<\/shipping>}m, '')).root
    adjustment = OrderAdjustment.create_from_element(element)
  
    # Assert!
    assert_equal Money.new(1205, 'USD'), adjustment.adjustment_total
    assert_equal true, adjustment.merchant_calculation_successful
    assert_equal [ :dummy_adjustment1, :dummy_adjustment2 ], adjustment.merchant_codes
    assert_equal nil, adjustment.shipping
    assert_equal Money.new(1105, 'USD'), adjustment.total_tax
  end
end