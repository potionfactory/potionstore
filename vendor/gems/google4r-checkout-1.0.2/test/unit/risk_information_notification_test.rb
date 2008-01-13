#--
# Project:   google_checkout4r 
# File:      test/unit/risk_info_notification_test.rb
# Author:    Dan Dukeson <dandukeson AT gmail.com>
# Copyright: (c) 2007 by Dan Dukeson
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
require 'rexml/document'
require 'test/frontend_configuration'

# Test for the class Area.
class Google4R::Checkout::RiskInformationNotificationTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new

    @example_xml = %q{
    <?xml version="1.0" encoding="UTF-8"?>
<risk-information-notification xmlns="http://checkout.google.com/schema/2" serial-number="4f5adc5b-aac5-4618-9e3b-75e60eaf29cd">
  <timestamp>2007-04-30T08:03:57.000Z</timestamp>
  <google-order-number>1564645586934214</google-order-number>
  <risk-information>
    <billing-address>
      <!-- Not to be tested here but in Address --
      <!--
      <contact-name>Mr Contact Smith</contact-name>
      <company-name>ACME Products</company-name>
      <email>contact_smith@example.com</email>
      <phone>012345 234567</phone>
      <fax>012345 345678</fax>
      <address1>123 Testing Road</address1>
      <address2>Test Village</address2>
      <country-code>GB</country-code>
      <city>Testcity</city>
      <region>South Testshire</region>
      <postal-code>S6 1TT</postal-code>
      -->
    </billing-address>
    <ip-address>123.456.123.456</ip-address>
    <avs-response>Y</avs-response>
    <cvn-response>M</cvn-response>
    <eligible-for-protection>true</eligible-for-protection>
    <partial-cc-number>6789</partial-cc-number>
    <buyer-account-age>61</buyer-account-age>
  </risk-information>
</risk-information-notification>
}

  end
  
  def test_create_from_element_works_correctly
    # Stub out Address creation.
    expectation = Address.stubs(:create_from_element).times(1).returns(:address)
    expectation.with { |param| param.name == 'billing-address' }
    
    root = REXML::Document.new(@example_xml).root
    
    notification = RiskInformationNotification.create_from_element(root, @frontend)
    
    assert_equal '4f5adc5b-aac5-4618-9e3b-75e60eaf29cd', notification.serial_number
    assert_equal '1564645586934214', notification.google_order_number
    assert_equal true, notification.eligible_for_protection
    
    assert_equal :address, notification.buyer_billing_address        
    
    assert_equal 'Y', notification.avs_response
    assert_equal 'M', notification.cvn_response
    assert_equal '6789', notification.partial_card_number
    assert_equal '123.456.123.456', notification.ip_address
    assert_equal 61, notification.buyer_account_age
    assert_equal Time.parse('2007-04-30T08:03:57.000Z'), notification.timestamp
  end
end
