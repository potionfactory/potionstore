#--
# Project:   google_checkout4r 
# File:      test/unit/private_data_parser_test.rb
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

# Test for the class PrivateDataParser.
class Google4R::Checkout::PrivateDataParserTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @xml_str1 = %q{<merchant-private-item-data>
      <item-note>Text 1</item-note>
      <item-note>Text 2</item-note>
      <nested>
        <tags>value</tags>
      </nested>
    </merchant-private-item-data>}
  end
  
  def test_responds_correctly
    assert_respond_to PrivateDataParser, :element_to_value
  end
  
  def test_parser_works_in_simple_example
    element = REXML::Document.new(@xml_str1).root.elements['//tags']
    
    assert_equal 'value', PrivateDataParser.element_to_value(element)
  end
  
  def test_parser_works_in_complex_example
    doc = REXML::Document.new(@xml_str1)
    
    hash = 
      {
        'item-note' => [ 'Text 1', 'Text 2' ],
        'nested' => { 'tags' => 'value' }
      }
    assert_equal hash, PrivateDataParser.element_to_value(doc.root)
  end
end