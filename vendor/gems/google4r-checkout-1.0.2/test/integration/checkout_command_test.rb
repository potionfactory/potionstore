#--
# Project:   google_checkout4r 
# File:      test/checkout/integration/checkout_command.rb
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

# Integration tests for the CheckoutCommand class.
#
# Tests the CheckoutCommand class against the Google Checkout Web Service.
class Google4R::Checkout::CheckoutCommandIntegrationTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
  end
  
  def test_sending_to_google_works_with_valid_request
    setup_command(@command)
    result = @command.send_to_google_checkout
    assert_kind_of CheckoutRedirectResponse, result
  end
  
  def test_using_invalid_credentials_raise_google_checkout_error
    invalid_patches = [ [ :merchant_id, 'invalid' ], [ :merchant_key, 'invalid' ] ]
    
    invalid_patches.each do |patch|
      config = FRONTEND_CONFIGURATION.dup
      config[patch[0]] = patch[1]
      @frontend = Frontend.new(config)
      @frontend.tax_table_factory = TestTaxTableFactory.new
      @command = @frontend.create_checkout_command

      setup_command(@command)
      assert_raises(GoogleCheckoutError) { @command.send_to_google_checkout }
    end
  end
  
  def test_invalid_xml_raises_google_checkout_error
    class << @command
      def to_xml
        ''
      end
    end
    
    setup_command(@command)
    assert_raises(GoogleCheckoutError) { @command.send_to_google_checkout }
  end
  
  protected
  
    # Sets up the given CheckoutCommand so it contains some
    # shipping methods and its cart contains some items.
    def setup_command(command)
      # Add shipping methods.
      command.create_shipping_method(FlatRateShipping) do |shipping|
        shipping.name = 'UPS Ground Shipping'
        shipping.price = Money.new(2000) # USD 20, GPB 20, etc.
        shipping.create_allowed_area(UsCountryArea) do |area|
          area.area = UsCountryArea::ALL
        end
      end
      
      # Add items to the cart.
      1.upto(5) do |i|
        command.shopping_cart.create_item do |item|
          item.name = "Test Item #{i}"
          item.description = "This is a test item (#{i})"
          item.unit_price = Money.new(350)
          item.quantity = i * 3
          item.id = "test-#{i}-123456789"
        end
      end
    end
end