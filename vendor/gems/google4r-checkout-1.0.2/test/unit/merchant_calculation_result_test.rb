#--
# Project:   google_checkout4r 
# File:      test/unit/merchant_calculation_result_test.rb
# Author:    Tony Chan <api dot htchan at gmail dot com>
# Copyright: (c) 2007 by Tony Chan
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

# Test for the class NewOrderConfirmation.
class Google4R::Checkout::MerchantCalculationResultTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    # Build up some Mocha expectations.
    expect = CouponResult.stubs(:new)
    expect.times(1).returns(:coupon_result)
    
    expect = GiftCertificateResult.stubs(:new)
    expect.times(1).returns(:gift_certificate_result)
    
    expect = Money.stubs(:new)
    expect.times(1).returns(:shipping_rate, :total_tax)

    @result = MerchantCalculationResult.new('UPS Ground', '1234567890', Money.new(1000, 'USD'), true, Money.new(2000, 'USD'))
  end
  
  def test_responds_correctly
    
    [ :shipping_name, :shipping_name=,
      :address_id, :address_id=, 
      :shipping_rate, :shipping_rate=,
      :shippable, :shippable=,
      :total_tax, :total_tax=,
      :merchant_code_results
    ].each do |symbol|
      assert_respond_to @result, symbol
    end
  end
  
  def test_create_merchant_code_result_works_correctly
    # Create the new CouponResult and GiftCertificationResult instances.
    @result.create_merchant_code_result(CouponResult)
    @result.create_merchant_code_result(GiftCertificateResult)
    
    # perform the assertions
    assert_equal 'UPS Ground', @result.shipping_name
    assert_equal '1234567890', @result.address_id
    assert_equal :shipping_rate, @result.shipping_rate
    assert_equal true, @result.shippable
    assert_equal :total_tax, @result.total_tax
    assert_equal [:coupon_result, :gift_certificate_result], @result.merchant_code_results
  end
end