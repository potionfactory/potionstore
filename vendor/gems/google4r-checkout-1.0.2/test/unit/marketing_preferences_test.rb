#--
# Project:   google_checkout4r 
# File:      test/unit/marketing_preferences_test.rb
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

# Test for the class MarketingPreferences.
class Google4R::Checkout::MarketingPreferencesTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
        <marketing-preferences>
          <email-allowed>%s</email-allowed>
        </marketing-preferences>
      }
  end

  def test_responds_correctly
    @preferences = MarketingPreferences.new

    [ :email_allowed, :email_allowed= ].each do |symbol|
      assert_respond_to @preferences, symbol
    end
  end
  
  def test_create_from_element_works_correctly
    { 'true' => true, 'True' => true, 'TRUE' => true, 'false' => false, 'Frue' => false, 
      'FALSE' => false }.each do |str, bool|
      xml_str = @xml_str % str
      
      element = REXML::Document.new(xml_str).root
      pref = MarketingPreferences.create_from_element(element)
      
      assert_equal bool, pref.email_allowed
    end
  end
end