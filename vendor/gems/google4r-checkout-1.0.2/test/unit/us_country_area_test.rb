#--
# Project:   google_checkout4r 
# File:      test/unit/us_country_area_test.rb
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

# Test for the class UsCountryArea.
class Google4R::Checkout::UsCountryAreaTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @area = UsCountryArea.new
  end
  
  def test_constants_are_defined
    assert defined?(UsCountryArea::CONTINENTAL_48)
    assert defined?(UsCountryArea::FULL_50_STATES)
    assert defined?(UsCountryArea::ALL)
  end
  
  def test_initialization
    assert_nil @area.area
  end

  def test_creator_sets_area
    area = UsCountryArea.new(UsCountryArea::ALL)
    assert_equal UsCountryArea::ALL, area.area
  end
  
  
  def test_us_country_area_behaves_correctly
    assert_respond_to @area, :area
    assert_respond_to @area, :area=
  end
  
  def test_us_country_area_area_accessor_works
    assert_nil @area.area
    
    [ UsCountryArea::CONTINENTAL_48, UsCountryArea::FULL_50_STATES, UsCountryArea::ALL ].each do |str|
      @area.area = str
      assert_equal str, @area.area
    end
  end
  
  def test_us_country_area_area_validation_works
    assert_raises(RuntimeError) { @area.area = 'invalid value' }
    assert_nil @area.area
  end
end