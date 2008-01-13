#--
# Project:   google_checkout4r 
# File:      test/unit/notification_handler_test.rb
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

# Test for the class NotificationHandler.
class Google4R::Checkout::NotificationHandlerTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @notification_handler = @frontend.create_notification_handler
    
    @xmls_with_known_tags =
      [
        [ 
          '<new-order-notification xmlns="http://checkout.google.com/schema/2" />',
          'new-order-notification',
          NewOrderNotification
        ],
        [
          '<order-state-change-notification xmlns="http://checkout.google.com/schema/2" />',
          'order-state-change-notification',
          OrderStateChangeNotification
        ],
        [
          '<risk-information-notification xmlns="http://checkout.google.com/schema/2" />',
          'risk-information-notification',
          RiskInformationNotification
        ],
        [
          '<charge-amount-notification xmlns="http://checkout.google.com/schema/2" />',
          'charge-amount-notification',
          ChargeAmountNotification
        ],
        [
          '<refund-amount-notification xmlns="http://checkout.google.com/schema/2" />',
          'refund-amount-notification',
          RefundAmountNotification
        ],
        [
          '<chargeback-amount-notification xmlns="http://checkout.google.com/schema/2" />',
          'chargeback-amount-notification',
          ChargebackAmountNotification
        ],
        [
          '<authorization-amount-notification xmlns="http://checkout.google.com/schema/2" />',
          'authorization-amount-notification',
          AuthorizationAmountNotification
        ],
      ]
    
    @xmls_with_unknown_tags =
      [
        '<unknown-notification />'
      ]
  end
  
  def test_handler_gets_initialized_correctly
    assert_equal @frontend, @notification_handler.frontend
  end
  
  def test_returns_correct_notification_class_for_known_notifications
    @xmls_with_known_tags.each do |triple|
      xml_str, tag_name, klass = triple
      
      expect = klass.stubs(:create_from_element)
      expect.times(1).returns(:foo)
      expect.with { |element, frontend| element.name == tag_name and frontend == @frontend }
      
      result = nil
      assert_nothing_raised {
        result = @notification_handler.handle(xml_str)
      }
      assert_equal :foo, result
    end
  end
  
  def test_raises_exception_on_unknown_notifications
    @xmls_with_unknown_tags.each do |xml_str|
      assert_raises(UnknownNotificationType) { @notification_handler.handle(xml_str) }
    end
  end
end
