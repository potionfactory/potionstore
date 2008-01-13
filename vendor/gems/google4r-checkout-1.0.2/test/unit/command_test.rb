#--
# Project:   google_checkout4r 
# File:      test/unit/command_test.rb
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

require 'net/http'

require 'base64'

class TestCommand < Google4R::Checkout::Command
  XML_REPRESENTATION = "<?xml version='1.0' ?><root />" 
  
  def to_xml
    XML_REPRESENTATION
  end
end

# Test for the class Command.
class Google4R::Checkout::CommandTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = TestCommand.new(@frontend)
  end
  
  def test_sending_fails_if_certificate_validation_fails
    OpenSSL::SSL::SSLSocket.any_instance.stubs(:connect).raises(OpenSSL::SSL::SSLError, 'certificate verify failed')
    
    assert_raises(OpenSSL::SSL::SSLError) { @command.send_to_google_checkout }
  end
  
  def test_to_xml_raises_not_implemented_error
    assert_raises(NotImplementedError) { Command.new(Frontend.new(FRONTEND_CONFIGURATION)).to_xml }
  end
  
  def test_unknown_xml_response_in_body_raises_runtime_error
    mock_body = '<?xml version="1.0" ?><unexpected-tag />'
    
    success_response = Net::HTTPSuccess.new(Net::HTTP.version_1_2, 200, "OK")
    success_response.expects(:body).returns(mock_body)
    
    Net::HTTP.any_instance.stubs(:request).returns(success_response)
    
    assert_raises(RuntimeError) { @command.send_to_google_checkout }
  end
  
  def test_invalid_response_code_raises_runtime_error
    unknown_response = mock()
    unknown_response.expects(:code)
    unknown_response.expects(:message)
    
    Net::HTTP.any_instance.stubs(:request).returns(unknown_response)
    
    assert_raises(RuntimeError) { @command.send_to_google_checkout }
  end
  
  def test_error_tag_in_response_code_raises_google_checkout_error
    mock_body = '<?xml version="1.0" encoding="UTF-8"?><error xmlns="http://checkout.google.com/schema/2" serial-number="foo-bar"><error-message>Malformed URL component: expected id: (\d{10})|(\d{15}), but got something-different</error-message></error>'
    
    error_response = Net::HTTPClientError.new(Net::HTTP.version_1_2, 400, "Bad Request")
    error_response.expects(:body).returns(mock_body)
    
    Net::HTTP.any_instance.stubs(:request).returns(error_response)
    
    assert_raises(GoogleCheckoutError) { @command.send_to_google_checkout }
  end
  
  def test_send_to_google_checkout_works_correctly_if_200_is_returned
    mock_body = '<?xml version="1.0" encoding="UTF-8"?><checkout-redirect xmlns="http://checkout.google.com/schema/2" serial-number="foo-bar"><redirect-url>https://sandbox.google.com/checkout/view/buy?o=shoppingcart&amp;shoppingcart=foo-bar</redirect-url></checkout-redirect>'
    
    success_response = Net::HTTPSuccess.new(Net::HTTP.version_1_2, 200, "OK")
    success_response.expects(:body).returns(mock_body)
    
    Net::HTTP.any_instance.stubs(:request).returns(success_response)

    Net::HTTP::Post.any_instance.expects(:basic_auth).with(FRONTEND_CONFIGURATION[:merchant_id], 
      FRONTEND_CONFIGURATION[:merchant_key])
    
    result = @command.send_to_google_checkout
    
    assert_kind_of CheckoutRedirectResponse, result
    assert_equal 'foo-bar', result.serial_number
    assert_equal 'https://sandbox.google.com/checkout/view/buy?o=shoppingcart&shoppingcart=foo-bar', result.redirect_url
  end
end