#--
# Project:   google_checkout4r 
# File:      test/unit/refund_order_command_test.rb
# Author:    Tony Chan <api.htchan at gmail dot com>
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

# Tests for the RefundOrderCommand class.
class Google4R::Checkout::RefundOrderCommandTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @command = @frontend.create_refund_order_command
    @command.google_order_number = '841171949013218'
    @command.amount = Money.new(1000, 'USD')
    @command.comment = 'Discount for inconvenience; ship replacement item'
    @command.reason = 'Damaged Merchandise'

    @sample_xml=%Q{<?xml version='1.0' encoding='UTF-8'?>
<refund-order xmlns='http://checkout.google.com/schema/2' google-order-number='841171949013218'>
  <amount currency='USD'>10.00</amount>
  <comment>Discount for inconvenience; ship replacement item</comment>
  <reason>Damaged Merchandise</reason>
</refund-order>}

    @sample_reason_only=%Q{<?xml version='1.0' encoding='UTF-8'?>
<refund-order xmlns='http://checkout.google.com/schema/2' google-order-number='841171949013218'>
  <reason>Damaged Merchandise</reason>
</refund-order>}
  end
  
  def test_behaves_correctly
    [ :google_order_number, :amount, :reason, :comment ].each do |symbol|
      assert_respond_to @command, symbol
    end
  end

  def test_xml_with_amount
    @command.amount = nil
    @command.comment = nil
    assert_strings_equal(@sample_reason_only, @command.to_xml)
  end

  def test_accessors
    assert_equal('841171949013218', @command.google_order_number)
    assert_equal(Money.new(1000, 'USD'), @command.amount)
    assert_equal('Discount for inconvenience; ship replacement item', @command.comment)
    assert_equal('Damaged Merchandise', @command.reason)
  end

  def test_xml_generation
    assert_strings_equal(@sample_xml, @command.to_xml)
  end

  def test_to_xml_does_not_raise_exception
    assert_nothing_raised { @command.to_xml }
  end

end
