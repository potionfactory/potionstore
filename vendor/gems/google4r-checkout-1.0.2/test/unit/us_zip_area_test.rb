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

# Test for the class UsZipArea.
class Google4R::Checkout::UsZipAreaTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @area = UsZipArea.new
  end
  
  def test_initialization
    assert_nil @area.pattern
  end
  
  def test_creator_sets_area
    area = UsZipArea.new('123*')
    assert_equal '123*', area.pattern
  end
  
  def test_us_zip_area_behaves_correctly
    # test that the methods and constants are defined correctly
    assert_respond_to @area, :pattern
    assert_respond_to @area, :pattern=
  end
  
  def test_us_zip_area_pattern_accessor_works
    assert_nil @area.pattern
    
    @area.pattern = '12345678'
    assert_equal '12345678', @area.pattern

    @area.pattern = '12*'
    assert_equal '12*', @area.pattern
  end
end