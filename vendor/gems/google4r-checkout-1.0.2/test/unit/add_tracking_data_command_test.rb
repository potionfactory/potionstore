#--
# Project:   google_checkout4r 
# File:      test/unit/add_tracking_data_command_test.rb
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

# Tests for the AddTrackingDataCommand class.
class Google4R::Checkout::AddTrackingDataCommandTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @command = @frontend.create_add_tracking_data_command

    @command.google_order_number = '841171949013218'
    @command.carrier = 'UPS'
    @command.tracking_number = 'Z9842W69871281267'

    @sample_xml=%Q{<?xml version='1.0' encoding='UTF-8'?>
<add-tracking-data xmlns='http://checkout.google.com/schema/2' google-order-number='841171949013218'>
  <tracking-data>
    <carrier>UPS</carrier>
    <tracking-number>Z9842W69871281267</tracking-number>
  </tracking-data>
</add-tracking-data>}
  end

  def test_behaves_correctly
    [ :google_order_number, :carrier, :tracking_number ].each do |symbol|
      assert_respond_to @command, symbol
    end
  end

  def test_xml
    assert_strings_equal(@sample_xml, @command.to_xml)
  end

  def test_accessors
    assert_equal('841171949013218', @command.google_order_number)
    assert_equal('Z9842W69871281267', @command.tracking_number)
    assert_equal('UPS', @command.carrier)
  end

  def test_to_xml_does_not_raise_exception
    assert_nothing_raised { @command.to_xml }
  end

end