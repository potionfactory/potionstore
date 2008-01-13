#--
# Project:   google_checkout4r 
# File:      test/unit/checkout_command_xml_generator_test.rb
# Authors:   Manuel Holtgrewe <purestorm at ggnore dot net>
#            Tony Chan <api.htchan at gmail dot com>
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

require 'tempfile'

require 'open3' rescue require 'win32/open3'

require 'rexml/document'

# Test for the class UsZipArea.
#
# TODO: Make the tests querying Google Checkout's diagnose service and the XSD validation optional.
class Google4R::Checkout::CheckoutCommandXmlGeneratorTest < Test::Unit::TestCase
  include Google4R::Checkout
  
  def setup
    @schema_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'xml', 'apiv2.xsd'))
    @expected_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'xml', 'test_check_persisting_works_expected.xml'))
    
    @frontend = Frontend.new(FRONTEND_CONFIGURATION)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
    @generator = CheckoutCommandXmlGenerator.new(@command)
  end
  
  # Note that this is not really a good test. We do not actually compare anything.
  # Instead, we simply generate some XML, validate it using XSD via xmllint and then
  # compare it to the output that we validated by reading it earlier.
  def test_check_persisting_works
    tax_tables = Array.new
    table = TaxTable.new(false)
    table.name = 'Default Table'
    table.create_rule do |rule|
      rule.rate = 0.04
      rule.area = UsCountryArea.new
      rule.area.area = UsCountryArea::ALL
    end
    table.create_rule do |rule|
      rule.area=Google4R::Checkout::PostalArea.new('GB', 'S6*')
      rule.shipping_taxed=true
      rule.rate=0.03
    end
    table.create_rule do |rule|
      rule.area=Google4R::Checkout::PostalArea.new('GB')
      rule.shipping_taxed=false
      rule.rate=0.07
    end
    table.create_rule do |rule|
      rule.area=Google4R::Checkout::WorldArea.new
      rule.shipping_taxed=true
      rule.rate=0.10
    end
    tax_tables << table
    nondefault_table = TaxTable.new(false)
    nondefault_table.name = 'Special Table'
    nondefault_table.create_rule do |rule|
      rule.rate = 0.02
      rule.area = UsCountryArea.new
      rule.area.area = UsCountryArea::ALL
    end
    tax_tables << nondefault_table
    
    TestTaxTableFactory.any_instance.stubs(:effective_tax_tables_at).returns(tax_tables)
    @frontend.tax_table_factory = TestTaxTableFactory.new
    @command = @frontend.create_checkout_command
    
    @command.continue_shopping_url = 'http://wwww.example.com/continue_shopping'
    @command.edit_cart_url = 'http://wwww.example.com/edit_cart'
    @command.request_buyer_phone_number = false
    @command.merchant_calculations_url = 'http://www.example.com/merchant_calcuations'
    @command.accept_merchant_coupons = true
    @command.accept_gift_certificates = true
    @command.platform_id = '1234567890'
    
    @generator = CheckoutCommandXmlGenerator.new(@command)
    
    @command.shopping_cart.expires_at = Time.parse('2007-11-29T15:33:20 UTC')
    
    @command.create_shipping_method(PickupShipping) do |shipping|
      shipping.name = 'Pickup Test Shipping'
      shipping.price = Money.new(100, 'USD')
    end
    
    @command.create_shipping_method(FlatRateShipping) do |shipping|
      shipping.name = 'State Test Shipping'
      shipping.price = Money.new(100, 'USD')
      
      shipping.create_allowed_area(UsStateArea)  { |area| area.state = 'CA' }
      shipping.create_excluded_area(UsStateArea) { |area| area.state = 'TX' }
    end
    
    @command.create_shipping_method(FlatRateShipping) do |shipping|
      shipping.name = 'Country Area Test Shipping'
      shipping.price = Money.new(100, 'USD')

      shipping.create_allowed_area(UsCountryArea)  { |area| area.area = UsCountryArea::FULL_50_STATES }
      shipping.create_excluded_area(UsCountryArea) { |area| area.area = UsCountryArea::CONTINENTAL_48 }
    end
    
    @command.create_shipping_method(FlatRateShipping) do |shipping|
      shipping.name = 'Zip Test Shipping'
      shipping.price = Money.new(100, 'USD')

      shipping.create_allowed_area(UsZipArea)  { |area| area.pattern = '1*' }
      shipping.create_excluded_area(UsZipArea) { |area| area.pattern = '12*' }
    end
    
    @command.shopping_cart.private_data = { 'we' => 'can pass in some data here'.split }
    
    1.upto(10) do |i|
      @command.shopping_cart.create_item do |item|
        item.name = "Item Name #{i}"
        item.description = "Description #{i}"
        item.unit_price = Money.new(i * 1000, 'USD')
        item.quantity = i * 2
        item.id = "Merchant ID #{i}"
        if i == 1 then
          item.private_data = { 'some' => { 'data' => 'Yeah, Yeah!' }, 'bars' => { 'bar' => [ 1, 2 ] } }
        end
        
        item.tax_table = nondefault_table if i % 2 == 1
      end
    end
    
    xml_str = @generator.generate
    assert_xml_validates_against_xml_schema(@schema_path, xml_str)
    assert_string_equals_file_contents(@expected_path, xml_str)
    assert_google_checkout_diagnose_returns_no_warnings(xml_str)
  end
  
  # Test that values within hashes are persisted correctly.
  def test_process_hash_processes_hash_values_correctly
    element = REXML::Element.new('root')
    @generator.instance_eval { process_hash(element, { 'key' => 'value' }) }
    assert_equal "<root><key>value</key></root>", element.to_s
  end
  
  protected
    
    def assert_google_checkout_diagnose_returns_no_warnings(xml_str)
      tmpfile = Tempfile.new('xml_output')
      tmpfile << xml_str
      tmpfile.flush

      url = "https://%s:%s@sandbox.google.com/checkout/cws/v2/Merchant/%s/request/diagnose" %
        [ FRONTEND_CONFIGURATION[:merchant_id], FRONTEND_CONFIGURATION[:merchant_key], 
          FRONTEND_CONFIGURATION[:merchant_id] ]

      stdin, stdout, stderr = Open3.popen3("curl -d @#{tmpfile.path} #{url}")
      outstr = stdout.read
      errstr = stderr.read
      
      assert (outstr != ''), 'curl command not available'
      
      # Check that there is no <warnings> tag in the XML.
      xml_document = REXML::Document.new(outstr)
      assert 0, xml_document.root.elements.to_a('//warnings').size
      
      tmpfile.close!
    end
  
    def assert_xml_validates_against_xml_schema(schema_path, xml_str)
      tmpfile = Tempfile.new('xml_output')
      tmpfile << xml_str
      tmpfile.flush
      
      #puts "---\n#{xml_str}\n---"

      stdin, stdout, stderr = Open3.popen3("xmllint --schema #{schema_path} #{tmpfile.path}")

      outstr = stdout.read
      errstr = stderr.read
      if errstr !~ /validates$/ then
        assert false, "The document did not validate: ---\nOUT:#{outstr}\nERR:#{errstr}\n---"
      else
        assert true
      end
      
      tmpfile.close!
    end
    
    def assert_string_equals_file_contents(expected_path, xml_str)
      file_contents = File.open(expected_path, 'r') { |f| f.read }
      assert_strings_equal file_contents, xml_str
    end
end
