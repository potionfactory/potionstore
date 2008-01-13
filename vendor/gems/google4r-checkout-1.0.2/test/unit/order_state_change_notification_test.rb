#--
# Project:   google_checkout4r 
# File:      test/unit/order_state_change_notification_test.rb
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

# Test for the class Area.
class Google4R::Checkout::OrderStateChangeNotificationTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @data = Hash.new
    @data[:serial_number] = "c821426e-7caa-4d51-9b2e-48ef7ecd6423"
    @data[:google_order_number] = "841171949013218"
    @data[:new_financial_order_state] = "CHARGING"
    @data[:previous_fulfillment_order_state] = "NEW"
    @data[:new_financial_order_state] = "CHARGEABLE"
    @data[:previous_fulfillment_order_state] = "NEW"
    @data[:reason] = "charge_customer"
    @data[:timestamp] = Time.new
    
    @xml_template = %q{<?xml version="1.0" encoding="UTF-8"?>
    <order-state-change-notification xmlns="http://checkout.google.com/schema/2" serial-number="%s">
        <google-order-number>%s</google-order-number>
        <new-financial-order-state>%s</new-financial-order-state>
        <new-fulfillment-order-state>%s</new-fulfillment-order-state>
        <previous-financial-order-state>%s</previous-financial-order-state>
        <previous-fulfillment-order-state>%s</previous-fulfillment-order-state>
        <reason>%s</reason>
        <timestamp>%s</timestamp>
    </order-state-change-notification>
    }

    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
  end
  
  def test_order_state_change_notification_responds_correctly
    assert_respond_to OrderStateChangeNotification, :create_from_element
    
    notification = OrderStateChangeNotification.new(@frontend)
    
    [ :serial_number, :google_order_number, :new_financial_order_state, :previous_fulfillment_order_state,
      :new_financial_order_state, :previous_fulfillment_order_state, :reason, :timestamp,
      :serial_number=, :google_order_number=, :new_financial_order_state=, :previous_fulfillment_order_state=,
      :new_financial_order_state=, :previous_fulfillment_order_state=, :reason=, :timestamp      
    ].each do |sym|
      assert_respond_to notification, sym
    end
  end

  def test_financial_order_state_defines_correct_constants
    assert defined?(FinancialOrderState::REVIEWING)
    assert defined?(FinancialOrderState::CHARGEABLE)
    assert defined?(FinancialOrderState::CHARGING)
    assert defined?(FinancialOrderState::CHARGED)
    assert defined?(FinancialOrderState::PAYMENT_DECLINED)
    assert defined?(FinancialOrderState::CANCELLED)
    assert defined?(FinancialOrderState::CANCELLED_BY_GOOGLE)

    assert_equal "REVIEWING", FinancialOrderState::REVIEWING
    assert_equal "CHARGEABLE", FinancialOrderState::CHARGEABLE
    assert_equal "CHARGING", FinancialOrderState::CHARGING
    assert_equal "CHARGED", FinancialOrderState::CHARGED
    assert_equal "PAYMENT_DECLINED", FinancialOrderState::PAYMENT_DECLINED
    assert_equal "CANCELLED", FinancialOrderState::CANCELLED
    assert_equal "CANCELLED_BY_GOOGLE", FinancialOrderState::CANCELLED_BY_GOOGLE
  end

  def test_fulfillment_order_state_defines_correct_constants
    assert defined?(FulfillmentOrderState::NEW)
    assert defined?(FulfillmentOrderState::PROCESSING)
    assert defined?(FulfillmentOrderState::DELIVERED)
    assert defined?(FulfillmentOrderState::WILL_NOT_DELIVER)

    assert_equal "NEW", FulfillmentOrderState::NEW
    assert_equal "PROCESSING", FulfillmentOrderState::PROCESSING
    assert_equal "DELIVERED", FulfillmentOrderState::DELIVERED
    assert_equal "WILL_NOT_DELIVER", FulfillmentOrderState::WILL_NOT_DELIVER
  end

  # <reason> in notification
  def test_create_from_xml_should_correctly_create_order_state_change_notification_with_reason
    [ true, false ].each do |skip_reason|
      xml_str = @xml_template % 
        [ 
          @data[:serial_number], @data[:google_order_number], @data[:new_financial_order_state],
          @data[:new_fulfillment_order_state], @data[:previous_financial_order_state],
          @data[:previous_fulfillment_order_state], @data[:reason], @data[:timestamp].iso8601
        ]
      
      xml_str = xml_str.gsub(/<reason>.*?<\/reason>/, '') if skip_reason
    
      notification = OrderStateChangeNotification.create_from_element(REXML::Document.new(xml_str).root, @frontend)
    
      @data.each do |key, value|
        next if skip_reason and key == :reason
        
        if key == :timestamp then
          assert_in_delta @data[:timestamp].to_f, notification.timestamp.to_f, 1
        else
          assert_equal @data[key], notification.send(key), "#{key}"
        end
      end
      
      assert_nil notification.reason if skip_reason
    end
  end
  
  def test_create_from_xml_should_raise_exception_with_missing_tags
    # Remove all required tags from the XML and expect the XPath query in
    # OrderStateChangeNotification#create_from_xml to evaluate to nil and thus
    # raise a NoMethodError.
    [ 'google-order-number', 'new-financial-order-state', 'new-fulfillment-order-state',
      'previous-financial-order-state', 'previous-fulfillment-order-state', 'timestamp' ].each do |tag_name|
      xml_str = @xml_template % 
        [ 
          @data[:serial_number], @data[:google_order_number], @data[:new_financial_order_state],
          @data[:new_fulfillment_order_state], @data[:previous_financial_order_state],
          @data[:previous_fulfillment_order_state], @data[:reason], @data[:timestamp].iso8601
        ]

      xml_str = xml_str.gsub(%r{<#{tag_name}>.*?</#{tag_name}>}, '')
      doc = REXML::Document.new(xml_str)

      assert_raises(NoMethodError, "Removed tag: #{tag_name} - #{xml_str}") {
        notification = OrderStateChangeNotification.create_from_element(doc.root, @frontend)
      }
    end
  end
end