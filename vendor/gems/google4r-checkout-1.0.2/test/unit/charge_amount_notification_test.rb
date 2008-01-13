#--
# Project:   google_checkout4r 
# File:      test/unit/charge_amount_notification_test.rb
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

# Test for the class ChargeAmountNotification
class Google4R::Checkout::ChargeAmountNotificationTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new

    @example_xml = %q{
<?xml version="1.0" encoding="UTF-8"?>
<charge-amount-notification xmlns="http://checkout.google.com/schema/2" serial-number="e91f167e-4f98-4b29-b793-80aaa6a61c911">
  <timestamp>2007-05-06T18:41:21.000Z</timestamp>
  <google-order-number>722226456784742</google-order-number>
  <latest-charge-amount currency="GBP">1.23</latest-charge-amount>
  <total-charge-amount currency="GBP">9.99</total-charge-amount>
</charge-amount-notification>
}
  end
  
  def test_create_from_element_works_correctly
    root = REXML::Document.new(@example_xml).root
    
    notification = ChargeAmountNotification.create_from_element(root, @frontend)

    assert_equal 'e91f167e-4f98-4b29-b793-80aaa6a61c911', notification.serial_number
    assert_equal '722226456784742', notification.google_order_number
    assert_equal Time.parse('2007-05-06T18:41:21.000Z'), notification.timestamp
    assert_equal(Money.new(999, 'GBP'), notification.total_charge_amount)
    assert_equal(Money.new(123, 'GBP'), notification.latest_charge_amount)
  end
end
