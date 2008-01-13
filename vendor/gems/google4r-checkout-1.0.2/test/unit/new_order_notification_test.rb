#--
# Project:   google_checkout4r 
# File:      test/unit/new_order_confirmation_test.rb
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

# Test for the class NewOrderConfirmation.
class Google4R::Checkout::NewOrderNotificationTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <new-order-notification xmlns="http://checkout.google.com/schema/2" serial-number="8571632143">
        <google-order-number>6014423719</google-order-number>
        <buyer-billing-address />
        <buyer-id>294873009217523</buyer-id>
        <buyer-marketing-preferences />
        <buyer-shipping-address />
        <financial-order-state>REVIEWING</financial-order-state>
        <fulfillment-order-state>NEW</fulfillment-order-state>
        <google-order-number>6014423719</google-order-number>
        <order-adjustment />
        <order-total currency="USD">321.98</order-total>
        <shopping-cart />
        <timestamp>2006-03-18T17:32:11</timestamp>
      </new-order-notification>}

    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
  end
  
  def test_responds_correctly
    assert_respond_to NewOrderNotification, :create_from_element
    
    notification = NewOrderNotification.new(@frontend)
    
    [ :serial_number, :google_order_number, :buyer_billing_address, :buyer_shipping_address,
      :buyer_id, :marketing_preferences, :financial_order_state, :fulfillment_order_state,
      :google_order_number, :order_adjustment, :order_total, :shopping_cart, :timestamp,
      :serial_number=, :google_order_number=, :buyer_billing_address=, :buyer_shipping_address=,
      :buyer_id=, :marketing_preferences=, :financial_order_state=, :fulfillment_order_state=,
      :google_order_number=, :order_adjustment=, :order_total=, :shopping_cart=, :timestamp=,
    ].each do |symbol|
      assert_respond_to notification, symbol
    end
  end
  
  def test_create_from_element_works_correctly
    # Build up some Mocha expectations.
    expect = Address.stubs(:create_from_element)
    expect.times(1).returns(:buyer_billing_address)
    expect.with{ |element| element.name == 'buyer-billing-address' }
    
    expect = Address.stubs(:create_from_element)
    expect.times(1).returns(:buyer_shipping_address)
    expect.with{ |element| element.name == 'buyer-shipping-address' }
    
    expect = MarketingPreferences.stubs(:create_from_element)
    expect.times(1).returns(:marketing_preferences)
    expect.with{ |element| element.name == 'buyer-marketing-preferences' }
    
    expect = OrderAdjustment.stubs(:create_from_element)
    expect.times(1).returns(:order_adjustment)
    expect.with{ |element| element.name == 'order-adjustment' }
    
    expect = ShoppingCart.stubs(:create_from_element)
    expect.times(1).returns(:shopping_cart)
    expect.with { |element, owner| element.name == 'shopping-cart' and owner.kind_of?(NewOrderNotification) }
    
    # Create the new notification.
    notification = NewOrderNotification.create_from_element(REXML::Document.new(@xml_str).root, @frontend)
    
    # perform the assertions
    assert_equal "8571632143", notification.serial_number
    assert_equal "6014423719", notification.google_order_number
    assert_equal :buyer_billing_address, notification.buyer_billing_address
    assert_equal :buyer_shipping_address, notification.buyer_shipping_address
    assert_equal "294873009217523", notification.buyer_id
    assert_equal :marketing_preferences, notification.marketing_preferences
    assert_equal "REVIEWING", notification.financial_order_state
    assert_equal "NEW", notification.fulfillment_order_state
    assert_equal "6014423719", notification.google_order_number
    assert_equal :order_adjustment, notification.order_adjustment
    assert_equal Money.new(32198, "USD"), notification.order_total
    assert_equal :shopping_cart, notification.shopping_cart
    assert_equal Time.parse("2006-03-18T17:32:11"), notification.timestamp
  end
 end