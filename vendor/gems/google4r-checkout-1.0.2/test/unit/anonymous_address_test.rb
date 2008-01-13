#--
# Project:   google_checkout4r 
# File:      test/unit/anonymous_address_test.rb
# Author:    Tony Chan <api dot htchan at gmail dot com>
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

# Test for the class Address.
class Google4R::Checkout::AnonymousAddressTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
<anonymous-address id="739030698069958">
  <country-code>US</country-code>
  <city>Mountain View</city>
  <region>CA</region>
  <postal-code>94043</postal-code>
</anonymous-address>}

  end
  
  def test_responds_correctly
    address = Address.new
    
    [ :address_id, :address_id=,
      :country_code, :country_code=,
      :city, :city=, :region, :region=,
      :postal_code, :postal_code=
    ].each do |symbol|
      assert_respond_to address, symbol
    end
  end
    
  def test_creating_anonymous_address
    
    document = REXML::Document.new(@xml_str)

    anonymous_address = AnonymousAddress.create_from_element(document.elements['/anonymous-address'])
    
    assert_equal '739030698069958', anonymous_address.address_id
    assert_equal 'US', anonymous_address.country_code
    assert_equal 'Mountain View', anonymous_address.city
    assert_equal 'CA', anonymous_address.region
    assert_equal '94043', anonymous_address.postal_code
    
  end
end
