#--
# Project:   google_checkout4r 
# File:      test/unit/merchant_code_test.rb
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

# Test for the class MerchantCode.
class Google4R::Checkout::MerchantCodeTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @valid_adjustment_types =
      [
        [ "GIFT_CERTIFICATE", 'gift-certificate-adjustment' ],
        [ "COUPON", 'coupon-adjustment' ],
      ]
    
    @optional_tag_names = [ 'calculated-amount', 'message' ]
    
    @invalid_adjustment_types = [ 'invalid-adjustment' ]
    
    @xml_str = %q{<?xml version="1.0" encodig="UTF-8"?>
      <%s>
        <applied-amount currency="%s">%s</applied-amount>
        <code>%s</code>
        <calculated-amount currency="%s">%s</calculated-amount>
        <message>%s</message>
      </%s>}
  end
  
  def test_constants_are_defined
    assert defined?(MerchantCode::GIFT_CERTIFICATE)
    assert defined?(MerchantCode::COUPON)
  end
  
  def test_responds_correctly
    adjustment = MerchantCode.new
    
    [ :applied_amount, :applied_amount=, :code, :code=, :calculated_amount, 
      :calculated_amount=, :message, :message=,
    ].each do |sym|
      assert_respond_to adjustment, sym
    end
  end

  def test_create_from_element_works_with_valid_adjustment_types
    @valid_adjustment_types.each do |pair|
      type, tag_name = pair
      
      @optional_tag_names.power.each do |optional_tag_names|
        xml_str = @xml_str % 
          [
            tag_name, 'USD', '10.00', 'some-code', 'USD', '20.00', 'Message!', tag_name
          ]
      
        optional_tag_names.each { |name| xml_str = xml_str.gsub(%r{<#{name}.*?</#{name}>}, '') }

        xml_doc = REXML::Document.new(xml_str)
        xml_element = xml_doc.root.elements["/#{tag_name}"]
      
        adjustment = MerchantCode.create_from_element(xml_element)
      
        assert_equal Money.new(1000, 'USD'), adjustment.applied_amount
        assert_equal type, adjustment.type
        assert_equal 'some-code', adjustment.code
        
        if not optional_tag_names.include?('calculated-amount') then
          assert_equal Money.new(2000, 'USD'), adjustment.calculated_amount
        else
          assert_nil adjustment.calculated_amount
        end
        if not optional_tag_names.include?('message') then
          assert_equal 'Message!', adjustment.message
        else
          assert_nil adjustment.message
        end
      end
    end
  end
  
  def test_create_from_element_raises_argument_error_with_invalid_shipping_adjustment_types
    @invalid_adjustment_types.each do |tag_name|
      xml_str = @xml_str % 
        [
          tag_name, 'USD', '10.00', 'some-code', 'USD', '20.00', 'Message!', tag_name
        ]
      
      xml_element = REXML::Document.new(xml_str).root
      
      assert_raises(ArgumentError) do
        adjustment = MerchantCode.create_from_element(xml_element)
      end
    end
  end
end