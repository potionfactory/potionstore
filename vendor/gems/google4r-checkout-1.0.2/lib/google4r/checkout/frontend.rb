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
    # The Frontend class is the factory that is to be used to create the Command,
    # NotificationHandler and CallbackHandler objects.
    #
    # === Example
    #
    #   configuration = { :merchant_id => '123456789', :merchant_key => '12345abcd' }
    #
    #   frontend = Google4R::Checkout::Frontend.new(configuration)
    #
    # == Tax Table Factory
    #
    # You have to set the tax_table_factory attribute of every Frontend object before you
    # can call #create_checkout_command or #create_notification_handler because the
    # objects created by those methods require tax tables.
    #
    # The Tax Table Factory must provide the method "effective_tax_tables_at" accept a Time 
    # object and provide a method that returns an Array of TaxTable object that describe the
    # effective tax rules at the given point of time.
    #
    # Effectively, this means you have to implement the Temporal Property pattern as described
    # here: http://www.martinfowler.com/ap2/temporalProperty.html.
    #
    # == Example
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
    #   frontend = Google4R::Checkout::Frontend.new(configuration)
    #   frontend.tax_table_factory = TaxTableFactory.new
    #
    #   checkout_command = frontend.create_checkout_command
    #   # ...
    #   handler = frontend.create_notification_handler
    class Frontend
      # The configuration for this Frontend class. It will be used by all classes created
      # by this Frontend instance (Hash).
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
      
      # Factory method that creates a new NotificationHandler object. Use this method to
      # create your NotificationHandler instances.
      def create_notification_handler
        return NotificationHandler.new(self)
      end
      
      # Factory method that creates a new CallbackHandler object. Use this method to
      # create your CallbackHandler instances.
      def create_callback_handler
        return CallbackHandler.new(self)
      end

      # Factory method to create a new DeliverOrderCommand object. Use this method to create
      # your DeliverOrderCommand instances.
      def create_deliver_order_command
        return DeliverOrderCommand.new(self)
      end

      # Factory method to create a new ChargeOrderCommand object. Use this method to create
      # your ChargeOrderCommand instances.
      def create_charge_order_command
        return ChargeOrderCommand.new(self)
      end
      
      # Factory method that creates a new CheckoutCommand object. Use this method to create 
      # your CheckoutCommand instances.
      def create_checkout_command
        return CheckoutCommand.new(self)
      end

      # Factory method to create a new CancelOrderCommand object. Use this method to create
      # your CancelOrderCommand instances.
      def create_cancel_order_command
        return CancelOrderCommand.new(self)
      end
      
      # Factory method to create a new RefundOrderCommand object. Use this method to create
      # your RefundOrderCommand instances.
      def create_refund_order_command
        return RefundOrderCommand.new(self)
      end
      
      # Factory method to create a new SendBuyerMessageCommand object. Use this method to create
      # your SendBuyerMessageCommand instances.
      def create_send_buyer_message_command
        return SendBuyerMessageCommand.new(self)
      end
      
      # Factory method to create a new AuthorizeOrderCommand object. Use this method to create
      # your AuthorizeOrderCommand instances.
      def create_authorize_order_command
        return AuthorizeOrderCommand.new(self)
      end

      # Factory method to create a new AddMerchantOrderNumberCommand object. Use this method to create
      # your AddMerchantOrderNumberCommand instances.
      def create_add_merchant_order_number_command
        return AddMerchantOrderNumberCommand.new(self)
      end
      
      # Factory method to create a new AddTrackingDataCommand object. Use this method to create
      # your AddTrackingDataCommand instances.
      def create_add_tracking_data_command
        return AddTrackingDataCommand.new(self)
      end

      # Factory method to create a new ArchiveOrderCommand object. Use this method to create
      # your ArchiveOrderCommand instances.
      def create_archive_order_command
        return ArchiveOrderCommand.new(self)
      end
      
      # Factory method to create a new UnarchiveOrderCommand object. Use this method to create
      # your UnarchiveOrderCommand instances.
      def create_unarchive_order_command
        return UnarchiveOrderCommand.new(self)
      end
    end
  end
end
