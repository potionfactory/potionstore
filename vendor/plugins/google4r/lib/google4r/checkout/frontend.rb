#--
# Project:   google4r
# File:      lib/google4r/checkout/frontend.rb
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
# This file provides the Google4R::Checkout::Frontend class that is a factory for the commands
# to be sent to Google Checkout.

module Google4R #:nodoc:
  module Checkout #:nodoc:
    # The Frontend class is the factory that is to be used to create the Command (and later
    # NotificationHandler) objects.
    #
    # === Example
    #
    #   configuration = { :merchant_id => '123456789', :merchant_key => '12345abcd' }
    #
    #   frontend = Google4R::Checkout::Frontend.new(configuration)
    #   command = frontend.create_checkout_command
    #
    # == Tax Table Factory
    #
    # You have to set the tax_table_factory attribute of every Frontend object before you
    # can call #create_checkout_command or #create_notification_handler because those
    # objects require tax tables.
    #
    # The Tax Table Factory must provide the method "effective_tax_tables_at" accept a Time 
    # object and provide a method that returns an Array of TaxTable object that describe the
    # effective tax rules at the given point of time.
    #
    #   class TaxTableFactory
    #     def effective_tax_tables_at(time)
    #       if time < Time.parse("Wed Apr 09 08:56:03 CDT 2003") then
    #         table1, table2 = TaxTable.new, TaxTable.new
    #         # ... set rules
    #         [ table1, table 2]
    #       else
    #         table3, table4 = TaxTable.new, TaxTable.new
    #         # ... set rules
    #         [ table3, table 4]
    #       end
    #     end
    #   end
    #
    #  frontend = Frontend.new
    #  frontend.tax_table_factory = TaxTableFactory.new
    class Frontend
      # The configuration for this Frontend class. It will be used by all classes created
      # by this Frontend instance.
      attr_reader :configuration
      
      # An object with a factory method that can create the effective TaxTable objects 
      # that were valid at a given point of time.
      attr_accessor :tax_table_factory
      
      # Creates a new Frontend instance and sets the configuration attribute to the parameter
      # configuration.
      def initialize(configuration)
        raise "Missing configuration setting: merchant_id"  if configuration[:merchant_id].nil?
        raise "Missing configuration setting: merchant_key" if configuration[:merchant_key].nil?
        raise "Missing configuration setting: use_sandbox"  if configuration[:use_sandbox].nil?
        
        @configuration = configuration.dup.freeze
      end
      
      # Factory method that creates a new CheckoutCommand object. Use this method to create 
      # your CheckoutCommand instances.
      def create_checkout_command
        return CheckoutCommand.new(self)
      end
      
      # Factory method that creates a new NotificationHandler object. Use this method to
      # create your NotificationHandler instances.
      def create_notification_handler
        return NotificationHandler.new(self)
      end

      def create_add_merchant_order_number_command
        return AddMerchantOrderNumberCommand.new(self)
      end

      def create_deliver_order_command
        return DeliverOrderCommand.new(self)
      end

      def create_archive_order_command
        return ArchiveOrderCommand.new(self)
      end
    end
  end
end
