#--
# Project:   google_checkout4r 
# File:      test/unit/merchant_calculation_callback_test.rb
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
class Google4R::Checkout::MerchantCalculationCallbackTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8"?>
<merchant-calculation-callback xmlns="http://checkout.google.com/schema/2">
    <shopping-cart>
        <merchant-private-data>
            <affiliate-code>01234</affiliate-code>
        </merchant-private-data>
        <cart-expiration>
            <good-until-date>2007-12-31T23:59:59-05:00</good-until-date>
        </cart-expiration>
        <items>
            <item>
                <merchant-item-id>GGLAA1453</merchant-item-id>
                <item-name>Dry Food Pack</item-name>
                <item-description>One pack of nutritious dried food for emergencies.</item-description>
                <quantity>1</quantity>
                <tax-table-selector>food</tax-table-selector>
                <unit-price currency="USD">4.99</unit-price>
            </item>
            <item>
                <merchant-item-id>MGS2GBMP3</merchant-item-id>
                <item-name>Megasound 2GB MP3 Player</item-name>
                <item-description>This portable MP3 player stores 500 songs.</item-description>
                <quantity>1</quantity>
                <unit-price currency="USD">179.99</unit-price>
                <merchant-private-item-data>
                    <merchant-product-id>1234567890</merchant-product-id>
                </merchant-private-item-data>
            </item>
        </items>
    </shopping-cart>
    <buyer-language>en_US</buyer-language>
    <calculate>
        <addresses>
            <anonymous-address id="739030698069958">
                <country-code>US</country-code>
                <city>Mountain View</city>
                <region>CA</region>
                <postal-code>94043</postal-code>
            </anonymous-address>
            <anonymous-address id="421273450774618">
                <country-code>US</country-code>
                <city>New York</city>
                <region>NY</region>
                <postal-code>10022</postal-code>
            </anonymous-address>
        </addresses>
        <tax>true</tax>
        <shipping>
            <method name="SuperShip"/>
            <method name="UPS Ground"/>
        </shipping>
        <merchant-code-strings>
            <merchant-code-string code="GiftCert012345"/>
            <merchant-code-string code="FirstVisitCoupon"/>
        </merchant-code-strings>
    </calculate>
</merchant-calculation-callback>}

    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
  end
  
  def test_responds_correctly
    assert_respond_to MerchantCalculationCallback, :create_from_element
    
    callback = MerchantCalculationCallback.new(@frontend)
    
    [ :shopping_cart, :shopping_cart=,
      :buyer_language, :buyer_language=,
      :anonymous_addresses, :tax, :tax=,
      :shipping_methods, :merchant_code_strings
    ].each do |symbol|
      assert_respond_to callback, symbol
    end
  end
  
  def test_create_from_element_works_correctly
    # Build up some Mocha expectations.
    
    expect = ShoppingCart.stubs(:create_from_element)
    expect.times(1).returns(:shopping_cart)
    expect.with { |element, owner| element.name == 'shopping-cart' and owner.kind_of?(MerchantCalculationCallback) }
    
    expect = AnonymousAddress.stubs(:create_from_element)
    expect.times(1).returns(:anonymous_address, :anonymous_address2)
    expect.with { |element| element.name == 'anonymous-address' }
    
    # Create the new notification.
    merchantCalculationCallback = MerchantCalculationCallback.create_from_element(REXML::Document.new(@xml_str).root, @frontend)
    
    # perform the assertions
    assert_equal :shopping_cart, merchantCalculationCallback.shopping_cart
    assert_equal 'en_US', merchantCalculationCallback.buyer_language
    assert_equal 'true', merchantCalculationCallback.tax
    assert_equal [:anonymous_address, :anonymous_address2], merchantCalculationCallback.anonymous_addresses
    assert_equal ['SuperShip', 'UPS Ground'], merchantCalculationCallback.shipping_methods
    assert_equal ['GiftCert012345', 'FirstVisitCoupon'], merchantCalculationCallback.merchant_code_strings
  end
 end