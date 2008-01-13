#--
# Project:   google_checkout4r 
# File:      test/unit/merchant_calculation_results_test.rb
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
class Google4R::Checkout::MerchantCalculationResultsTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version='1.0' encoding='UTF-8'?>
<merchant-calculation-results xmlns='http://checkout.google.com/schema/2'>
  <results>
    <result address-id='739030698069958' shipping-name='SuperShip'>
      <shipping-rate currency='USD'>7.03</shipping-rate>
      <shippable>true</shippable>
      <merchant-code-results>
        <coupon-result>
          <valid>true</valid>
          <code>FirstVisitCoupon</code>
          <calculated-amount currency='USD'>5.00</calculated-amount>
          <message>Congratulations! You saved $5.00 on your first visit!</message>
        </coupon-result>
        <gift-certificate-result>
          <valid>true</valid>
          <code>GiftCert012345</code>
          <calculated-amount currency='USD'>10.00</calculated-amount>
          <message>You used your Gift Certificate!</message>
        </gift-certificate-result>
      </merchant-code-results>
    </result>
    <result address-id='739030698069958' shipping-name='UPS Ground'>
      <shipping-rate currency='USD'>5.56</shipping-rate>
      <shippable>true</shippable>
      <total-tax currency='USD'>14.67</total-tax>
      <merchant-code-results>
        <coupon-result>
          <valid>true</valid>
          <code>FirstVisitCoupon</code>
          <calculated-amount currency='USD'>5.00</calculated-amount>
          <message>Congratulations! You saved $5.00 on your first visit!</message>
        </coupon-result>
        <gift-certificate-result>
          <valid>true</valid>
          <code>GiftCert012345</code>
          <calculated-amount currency='USD'>10.00</calculated-amount>
          <message>You used your Gift Certificate!</message>
        </gift-certificate-result>
      </merchant-code-results>
    </result>
    <result address-id='421273450774618' shipping-name='SuperShip'>
      <shipping-rate currency='USD'>9.66</shipping-rate>
      <shippable>true</shippable>
      <total-tax currency='USD'>17.57</total-tax>
      <merchant-code-results>
        <coupon-result>
          <valid>true</valid>
          <code>FirstVisitCoupon</code>
          <calculated-amount currency='USD'>5.00</calculated-amount>
          <message>Congratulations! You saved $5.00 on your first visit!</message>
        </coupon-result>
        <gift-certificate-result>
          <valid>true</valid>
          <code>GiftCert012345</code>
          <calculated-amount currency='USD'>10.00</calculated-amount>
          <message>You used your Gift Certificate!</message>
        </gift-certificate-result>
      </merchant-code-results>
    </result>
    <result address-id='421273450774618' shipping-name='UPS Ground'>
      <shipping-rate currency='USD'>7.68</shipping-rate>
      <shippable>true</shippable>
      <total-tax currency='USD'>17.57</total-tax>
      <merchant-code-results>
        <coupon-result>
          <valid>true</valid>
          <code>FirstVisitCoupon</code>
          <calculated-amount currency='USD'>5.00</calculated-amount>
          <message>Congratulations! You saved $5.00 on your first visit!</message>
        </coupon-result>
        <gift-certificate-result>
          <valid>true</valid>
          <code>GiftCert012345</code>
          <calculated-amount currency='USD'>10.00</calculated-amount>
          <message>You used your Gift Certificate!</message>
        </gift-certificate-result>
      </merchant-code-results>
    </result>
  </results>
</merchant-calculation-results>}

    @results = MerchantCalculationResults.new
    
  end
  
  def test_responds_correctly
    
    [ :merchant_calculation_results
    ].each do |symbol|
      assert_respond_to @results, symbol
    end
  end
  
  def test_to_xml_works_correctly
    @coupon_result = CouponResult.new(true, 'FirstVisitCoupon', Money.new(500, 'USD'), 'Congratulations! You saved $5.00 on your first visit!')
    @gift_certificate_result = GiftCertificateResult.new(true, 'GiftCert012345', Money.new(1000, 'USD'), 'You used your Gift Certificate!')
    
    @results.create_merchant_calculation_result do |result|
      result.shipping_name = 'SuperShip'
      result.address_id = '739030698069958'
      result.shipping_rate = Money.new(703, 'USD')
      result.shippable = true
      result.create_merchant_code_result(@coupon_result)
      result.create_merchant_code_result(@gift_certificate_result)
    end
    
    @results.create_merchant_calculation_result do |result|
      result.shipping_name = 'UPS Ground'
      result.address_id = '739030698069958'
      result.shipping_rate = Money.new(556, 'USD')
      result.shippable = true
      result.total_tax = Money.new(1467, 'USD')
      result.create_merchant_code_result(@coupon_result)
      result.create_merchant_code_result(@gift_certificate_result)
    end
    
    @results.create_merchant_calculation_result do |result|
      result.shipping_name = 'SuperShip'
      result.address_id = '421273450774618'
      result.shipping_rate = Money.new(966, 'USD')
      result.shippable = true
      result.total_tax = Money.new(1757, 'USD')
      result.create_merchant_code_result(@coupon_result)
      result.create_merchant_code_result(@gift_certificate_result)
    end
    
    @results.create_merchant_calculation_result do |result|
      result.shipping_name = 'UPS Ground'
      result.address_id = '421273450774618'
      result.shipping_rate = Money.new(768, 'USD')
      result.shippable = true
      result.total_tax = Money.new(1757, 'USD')
      result.create_merchant_code_result(@coupon_result)
      result.create_merchant_code_result(@gift_certificate_result)
    end

    # perform the assertions
    assert_strings_equal @xml_str, @results.to_xml
  end
 end