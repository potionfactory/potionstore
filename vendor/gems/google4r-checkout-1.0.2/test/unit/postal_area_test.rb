require 'google4r/checkout'

require 'test/frontend_configuration'
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

# Test for the class Area.
class Google4R::Checkout::PostalAreaTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @area = PostalArea.new('GB', 'S6*')
  end
  
  def test_initialization_works
    assert_equal 'GB' , @area.country_code
    assert_equal 'S6*', @area.postal_code_pattern
  end
  
  def test_us_state_area_behaves_correctly
    assert_respond_to @area, :country_code
    assert_respond_to @area, :country_code=
    assert_respond_to @area, :postal_code_pattern
    assert_respond_to @area, :postal_code_pattern=
  end
  
  def test_accessors_should_work
    @area.postal_code_pattern = '100*'
    assert_equal '100*', @area.postal_code_pattern
    
    @area.country_code = 'DE'
    assert_equal 'DE', @area.country_code
  end
  
  def test_initialize_without_postcode_works
    pa = PostalArea.new('DE')
    assert_equal 'DE', pa.country_code
    assert_nil pa.postal_code_pattern
  end
 
end
