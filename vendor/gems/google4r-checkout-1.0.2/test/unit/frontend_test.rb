#--
# Project:   google_checkout4r 
# File:      test/unit/frontend_test.rb
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

# Test for the class Area and all of its subclasses.
class Google4R::Checkout::FrontendTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
  end
  
  def test_initialized_correctly
    assert_equal FRONTEND_CONFIGURATION.dup, @frontend.configuration
    assert @frontend.configuration.frozen?
  end
  
  def test_frontend_behaves_correctly
    [ :create_checkout_command, :configuration, :tax_table_factory, 
      :tax_table_factory=
    ].each do |symbol|
      assert_respond_to @frontend, symbol
    end
  end
  
  def test_create_checkout_command_works_correctly
    assert_kind_of CheckoutCommand, @frontend.create_checkout_command
  end
  
  def test_create_notification_handler_works_correctly
    assert_kind_of NotificationHandler, @frontend.create_notification_handler
  end

  def test_create_charge_order_command_works_correctly
    assert_kind_of ChargeOrderCommand, @frontend.create_charge_order_command
  end

  def test_create_deliver_order_command_works
    assert_kind_of DeliverOrderCommand, @frontend.create_deliver_order_command
  end

  def test_create_cancel_order_command_works
    assert_kind_of CancelOrderCommand, @frontend.create_cancel_order_command
  end

end
