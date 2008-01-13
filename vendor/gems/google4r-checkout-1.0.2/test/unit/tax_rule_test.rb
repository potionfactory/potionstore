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

# Tests for the TaxRule class.
class Google4R::Checkout::TaxRuleTest < Test::Unit::TestCase
  include Google4R::Checkout

  def setup
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
    @table = TaxTable.new(false)
    @rule = @table.create_rule
  end
  
  def test_tax_rule_gets_initialized_correctly
    assert_equal @table, @rule.table
    assert_nil @rule.area
    assert_nil @rule.rate
    assert !@rule.shipping_taxed
  end
  
  def test_tax_rule_behaves_correctly
    assert_respond_to @rule, :table
    assert_respond_to @rule, :area
    assert_respond_to @rule, :rate
    assert_respond_to @rule, :shipping_taxed
  end
  
  def test_tax_rule_accessors_work
    @rule.area = :area
    assert_equal :area, @rule.area
    
    @rule.rate = 0.5
    assert_equal 0.5, @rule.rate

    @rule.shipping_taxed=true
    assert @rule.shipping_taxed
  end
end
