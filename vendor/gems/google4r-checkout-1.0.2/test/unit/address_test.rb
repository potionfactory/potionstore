#--
# Project:   google_checkout4r 
# File:      test/unit/address_test.rb
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

# Test for the class Address.
class Google4R::Checkout::AddressTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @data =
      {
        :contact_name => 'John Smith',
        :email => 'johnsmith@example.com',
        :fax => '+01123456789',
        :phone => '+01123456789',
        :address1 => '10 Example Road',
        :address2 => 'Bar',
        :city => 'Sampleville',
        :company_name => 'Company Name',
        :region => 'CA',
        :postal_code => '94141',
        :country_code => 'US',
      }
    
    @optional_fields = [ :fax, :phone, :address2, :company_name, :contact_name ]
    
    @xml_str = %q{<?xml version="1.0" encoding="UTF-8" ?>
      <root>
        <some-address>
          <contact-name>%s</contact-name>
          <email>%s</email>
          <fax>%s</fax>
          <phone>%s</phone>
          <address1>%s</address1>
          <address2>%s</address2>
          <city>%s</city>
          <company-name>%s</company-name>
          <region>%s</region>
          <postal-code>%s</postal-code>
          <country-code>%s</country-code>
      </some-address>
    </root>}
  end
  
  def test_responds_correctly
    @address = Address.new
    
    @data.each do |key, value|
      assert_respond_to @address, key, "key == #{key}"
      assert_respond_to @address, "#{key}=".to_sym, "key == #{key}"
    end
  end
    
  def test_creating_address_with_full_fields_works
    xml_str = @xml_str % 
      [
        @data[:contact_name], @data[:email], @data[:fax], @data[:phone], @data[:address1],
        @data[:address2], @data[:city], @data[:company_name], @data[:region], 
        @data[:postal_code], @data[:country_code]
      ]
    
    document = REXML::Document.new(xml_str)
    
    the_element = document.elements['/root/some-address']
    
    address = Address.create_from_element(the_element)
    
    @data.each do |key, value|
      assert_equal value, address.send(key)
    end
  end
  
  def test_creating_address_works_when_removing_optional_fields
    @optional_fields.power.each do |optional_symbols|
      xml_str = @xml_str % 
        [
          @data[:contact_name], @data[:email], @data[:fax], @data[:phone], @data[:address1],
          @data[:address2], @data[:city], @data[:company_name], @data[:region], 
          @data[:postal_code], @data[:country_code]
        ]

      # Remove all optional symbols in this run.
      optional_symbols.each do |symbol|
        xml_str = xml_str.gsub(%r{<#{symbol.to_s.gsub('_', '-')}>.*?</#{symbol.to_s.gsub('_', '-')}>}, '')
      end

      document = REXML::Document.new(xml_str)

      the_element = document.elements['/root/some-address']

      address = Address.create_from_element(the_element)

      @data.each do |key, value|
        if optional_symbols.include?(key) then
          assert_nil address.send(key)
        else
          assert_equal value, address.send(key)
        end
      end
    end
  end
end
