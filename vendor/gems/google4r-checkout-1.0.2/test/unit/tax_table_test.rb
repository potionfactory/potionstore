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

# Test for the TaxTable class.
class Google4R::Checkout::TaxTableTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @table = TaxTable.new(false)
  end
  
  def test_table_behaves_correctly
    assert_respond_to @table, :rules
    assert_respond_to @table, :name
    assert_respond_to @table, :name=
    assert_respond_to @table, :standalone
  end
  
  def test_initialized_correctly
    assert_nil @table.name
    assert_equal [], @table.rules
    assert_equal false, @table.standalone
  end
  
  def test_accessors_work_correctly
    @table.name = "name"
    assert_equal "name", @table.name
  end
  
  def test_create_rule_works_correctly_with_block
    the_rule = nil
    
    res =
      @table.create_rule do |rule|
        the_rule = rule
        assert_kind_of TaxRule, rule
      end
    
    assert_equal res, the_rule
    assert @table.rules.include?(the_rule)
  end
  
  def test_create_rule_works_correctly_without_block
    res = nil
    
    res = @table.create_rule
    
    assert_kind_of TaxRule, res
    
    assert @table.rules.include?(res)
  end
end