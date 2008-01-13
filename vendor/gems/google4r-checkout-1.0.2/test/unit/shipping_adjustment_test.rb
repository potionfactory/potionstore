#--
# Project:   google_checkout4r 
# File:      test/unit/shipping_adjustment_test.rb
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

# Test for the class ShippingAdjustmentTest.
class Google4R::Checkout::ShippingAdjustmentTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <%s>
        <shipping-name>%s</shipping-name>
        <shipping-cost currency="%s">%s</shipping-cost>
      </%s>}
    
    @valid_adjustment_types =
      [
        [ "FLAT_RATE", 'flat-rate-shipping-adjustment' ],
        [ "PICKUP", 'pickup-shipping-adjustment' ],
      ]
    
    @invalid_adjustment_types = [ 'merchant-calculated-shipping', 'invalid-shipping' ]
  end
  
  def test_responds_correctly
    adjustment = ShippingAdjustment.new
    
    [ :type, :type=, :name, :name=, :cost, :cost= ].each do |symbol|
      assert_respond_to adjustment, symbol
    end
  end
  
  def test_constants_are_defined
    assert defined?(ShippingAdjustment::FLAT_RATE)
    assert defined?(ShippingAdjustment::PICKUP)
  end
  
  def test_create_from_element_works_with_valid_shipping_adjustment_types
    @valid_adjustment_types.each do |pair|
      type, tag_name = pair
      
      xml_str = @xml_str % 
        [
          tag_name, 'Some Name', 'USD', '10.00', tag_name
        ]
      
      element = REXML::Document.new(xml_str).root
      
      adjustment = ShippingAdjustment.create_from_element(element)
      
      assert_equal Money.new(1000, 'USD'), adjustment.cost
      assert_equal type, adjustment.type
      assert_equal 'Some Name', adjustment.name
    end
  end
  
  def test_create_from_element_raises_exception_with_invalid_shipping_adjustment_types
    @invalid_adjustment_types.each do |tag_name|
      xml_str = @xml_str % 
        [
          tag_name, 'Some Name', 'USD', '10.00', tag_name
        ]
      
      element = REXML::Document.new(xml_str).root
      
      assert_raises(RuntimeError) do
        adjustment = ShippingAdjustment.create_from_element(element)
      end
    end
  end
end