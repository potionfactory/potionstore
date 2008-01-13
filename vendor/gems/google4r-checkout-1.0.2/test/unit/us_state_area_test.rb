#--
# Project:   google_checkout4r 
# File:      test/unit/area_test.rb
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

# Test for the class UsStateArea.
class Google4R::Checkout::UsStateAreaTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @area = UsStateArea.new
  end
  
  def test_initialization
    assert_nil @area.state
  end
  
  def test_creator_sets_state
    area = UsStateArea.new('CA')
    assert_equal 'CA', area.state
  end
  
  def test_us_state_area_behaves_correctly
    assert_respond_to @area, :state
    assert_respond_to @area, :state=
  end
  
  def test_us_country_area_area_accessor_works
    assert_nil @area.state
    
    @area.state = 'CA'
    assert_equal 'CA', @area.state
  end
  
  def test_us_country_area_area_must_have_the_correct_format
    assert_raises(RuntimeError) { @area.state = 'ca' }
    assert_nil @area.state
    
    assert_raises(RuntimeError) { @area.state = 'CAL' }
    assert_nil @area.state
  end
end