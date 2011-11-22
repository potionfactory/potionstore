require 'pp'
require 'net/http'
require 'net/https'
require 'uri'
require 'ruby-paypal/credit_card_checks'

SANDBOX_SERVER = 'https://api-3t.sandbox.paypal.com/nvp'
PRODUCTION_SERVER = 'https://api-3t.paypal.com/nvp'
API_VERSION = '63.0'

module Net
  #
  # A convenience class to enable this library to call PayPal's HTTPS NVP APIs
  #
  class HTTPS < HTTP
    def initialize(address, port = nil, verify = :no_verify)
      super(address, port)
      self.use_ssl = true
      self.verify_mode = OpenSSL::SSL::VERIFY_NONE if verify == :no_verify
    end
  end
end

#
# A container for the response from PayPal. Each call to PayPal returns a generic set
# of information as well as a specific set for the call. For more information please refer
# to PayPal NVP API Developer Guide and Reference.
#
# To use retrieve information in the response, call the corresponding name of the object. For
# example, all responses from PayPal includes the field <tt>ACK</tt>. To get the data for this
# field:
#
#
#   if response.ack == 'Success' then
#    # do your stuff
#   end
#
# This is because this class uses a meta-programming trick with method_missing to redirect all
# known method calls to its internal hash data structure.
#
class PayPalResponse < Hash
  def method_missing(m,*a)
    if m.to_s.upcase =~ /=$/
      self[$`] = a[0]
    elsif a.empty?
      self[m.to_s.upcase]
    else
      raise NoMethodError, "#{m}"
    end
  end
end


# Container used for mass payment
#
class PayPalPayment
  attr_accessor :email, :receiver_id, :unique_id, :note, :amount
end


=begin rdoc
Author::	Chang Sau Sheong  (mailto:sausheong.chang@gmail.com)
Author::	Philippe F. Monnet (mailto:pfmonnet@gmail.com)
Copyright:: Copyright (c) 2007-2009 Chang Sau Sheong & Philippe F. Monnet
License::   Distributes under the same terms as Ruby
Version:: 0.0.5

:main: Paypal

=Installing Ruby-PayPal
A lightweight ruby wrapper for PayPal NVP (Name-Value Pair) APIs. To install type the following
at the command line:

  $ gem install ruby-paypal


=Using Ruby-PayPal
It's critical that you understand how PayPal works and how the PayPal NVP API
works. You should be relatively well-versed in the NVP API Developer Guide and
Reference - see:
- https://www.paypal.com/en_US/ebook/PP_NVPAPI_DeveloperGuide/index.html
- https://cms.paypal.com/us/cgi-bin/?&cmd=_render-content&content_ID=developer/e_howto_api_soap_NVPAPIOverview

You should also visit and register yourself with the PayPal Developer Network
and get a Sandbox account with in the PayPal Development Central
(https://developer.paypal.com/).

Note that this library only supports the API signature method of securing the API credentials.

By setting Paypal.debug=true, the API will "pretty-print" the PayPal parameters to the console.

==Direct Payment
To use credit card payment through PayPal, you need to use the DoDirectPayment APIs:

	username = <PayPal API username>
	password = <PayPal API password>
	signature = <PayPal API signature>

	ipaddress = '192.168.1.1' # can be any IP address
	amount = '100.00' # amount paid
	card_type = 'VISA' # can be Visa, Mastercard, Amex etc
	card_no = '4512345678901234' # credit card number
	exp_date = '022010' # expiry date of the credit card
	first_name = 'Sau Sheong'
	last_name = 'Chang'

    paypal = Paypal.new(username, password, signature) # uses the PayPal sandbox
    response = paypal.do_direct_payment_sale(ipaddress, amount, card_type,
			   card_no, exp_date, first_name, last_name)
	if response.ack == 'Success' then
	  # do your thing
	end

The above code is for a final sale only.

Note that the credit card number is checked against a modulo-10 algorithm (Luhn check) as well as a simple credit card
type check. For more information please refer to http://en.wikipedia.org/wiki/Luhn_algorithm and
http://en.wikipedia.org/wiki/Credit_card_number

==Express Checkout
To use the customer's PayPal account for payment, you will need to use the ExpressCheckout APIs:

<to be documented>

==PayPal Subscriptions

PayPal Subscriptions is a service offering allowing you to sell subscriptions, consisting of an initial payment followed by
several recurring payments. For a good technical overview, review the following guide:
- https://www.paypal.com/en_US/ebook/PP_ExpressCheckout_IntegrationGuide/RecurringPayments.html

Using the subscriptions service involve understanding the series of exchanges to perform using the NVP API.
There are 3 key phases of a subscription:
1. Creating a subscription request (and button for the customer)
2. Customer review and confirmation on the PayPal site
3. Processing of a subscription agreement
Each phase involves specific APIs.

===Phase 1 - Subscription Request
In this phase, the do_set_express_checkout method will be called. PayPal will return a token we can use in subsequent API calls.

Let's create a subcription request with the details of our subscription:

	subscription_request = create_monthly_subscription_request(
		name='_Why's Ruby Camping Adventures',
		id='MNWRCA',
		description='_Why's Ruby Camping Adventures - Monthly Tips And Tricks For Camping Development',
		invoice_number='INV20091122',
		amount='5.00')

Let's call do_set_express_checkout to get a token back:

	response = paypal.do_set_express_checkout(
		return_url='http://www.yoursite.com/subscription-confirmed',
		cancel_url='http://www.yoursite.com/subscription-aborted',
		amount='5.00',
		other_params=subscription_request)

	token = (response.ack == 'Success') ? response['TOKEN'] : ''

Let's use the token to create a PayPal button to request payment via the sandbox:

	form( { :method => 'post' ,
				:action => 'https://www.sandbox.paypal.com/cgi-bin/webscr' #sandbox
				} ) do

			input :id => 'cmd', :name => 'cmd', :type => 'hidden',
				  :value => "_express-checkout";

			input :id => 'token', :name => 'token', :type => 'hidden',
				  :value => "#{token}";

			input :id => 'submit_subscription_request', :name => 'submit', :type => 'submit',
				  :value => 'Subscribe Via PayPal'
	end #form

===Phase 2 - Customer Review and Confirmation

The customer will see the details of the subscription agreement we created previously.
Upon confirmation, PayPal will redirect the customer to the return_url we specified passing
the token back as well as the payerid.

===Phase 3 = Subscription Processing

First we will retrieve the details of the check-out:

	response = paypal.do_get_express_checkout_details(token)

Then we will execute the actual payment:

	response = paypal.do_express_checkout_payment(token=token,
		payment_action='Sale',
		payer_id=payerid,
		amount='5.00')

	transaction_id = response['TRANSACTIONID']

Now we can create the actual PayPal subscription

	response = @paypal.do_create_recurring_payments_profile(token,
		start_date='2009-11-22 14:30:10',
		profile_reference='INV20091122',
		description='_Why's Ruby Camping Adventures - Monthly Tips And Tricks For Camping Development',
		billing_period='Month',
		billing_frequency=1,
		total_billing_cycles=11,
		amount='5.00',
		currency='USD')

	profile_id = @response['PROFILEID']

The profile_id can then be used in the future to access the details of the subscription,
suspend it, reactivate it or cancel it using the following methods:
- do_get_recurring_payments_profile_details

	response = paypal.do_get_recurring_payments_profile_details(profile_id)

- do_manage_recurring_payments_profile_status

	# Suspend
	response = paypal.do_manage_recurring_payments_profile_status(profile_id,
		action='Suspend',
		note='The subscription is being suspended due to payment cancellation by the customer')

	# Re-Activate
	response = paypal.do_manage_recurring_payments_profile_status(profile_id,
		action='Reactivate',
		note='The subscription is being reactivated due to new payment by the customer')

	# Cancel
	response = paypal.do_manage_recurring_payments_profile_status(profile_id,
		action='Cancel',
		note='The subscription is being cancelled due to cancellation of the account by the customer')

The customer information associated with the subscription can be retrieved using:
- do_get_billing_agreement_customer_details

	response = paypal.do_get_billing_agreement_customer_details(token)

Note: all subscriptions methods also accept an optional other_params hash for any other NVP you need to pass.


=More information
Check for updates in our blogs:
- http://blog.saush.com
- http://blog.monnet-usa.com
=end

class PayPal
  include CreditCardChecks

  @@debug = false

  def self.debug
	@@debug
  end

  # Controls whether or not PP debug statements will be produced and sent to the console
  #
  def self.debug=(val) #:doc:
	@@debug = val
  end

  def self.express_checkout_redirect_url(token, useraction = nil)
    live = Rails.env == 'production'
    if live
      url = "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{token}"
    else
      url = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{token}"
    end
    url << "&useraction=#{useraction}" if useraction
    return url
  end

  def self.make_nvp_call(params)
    self.new.make_nvp_call(params)
  end

  # Create a new object with the given user name, password and signature. To enable production
  # access to PayPal change the url to the live PayPal server. Set url to <tt>:production</tt> to change
  # access to PayPal production servers.
  #
  def initialize()
    environment = Rails.env
    app_root = File.dirname(__FILE__) + '/../..'
    config_dir = app_root + '/config'

    prefs = File.expand_path(config_dir + '/paypal.yml')
    if File.exists?(prefs)
      y = YAML.load(File.open(prefs))
      y.each {|pref, value| eval("@#{pref} =\"#{value}\"")}
      y[environment].each {|pref, value| eval("@#{pref} =\"#{value}\"")}
    end

    @api_parameters = {
      'USER' => @api_username,
      'PWD' => @api_password,
      'VERSION' => API_VERSION,
      'SIGNATURE' => @api_signature
    }

    if environment == 'production'
      @paypal_url = PRODUCTION_SERVER
    else
      @paypal_url = SANDBOX_SERVER
    end
  end

    # Performs credit card payment with PayPal, but only requesting for authorization. You need
    # to capture the funds later. Calls do_direct_payment.
    #
    # Equivalent of DoDirectPayment with the PAYMENTACTION of 'authorization'
    #
    def do_direct_payment_authorization(ipaddress, amount, credit_card_type, credit_card_no, expiry_date,
      first_name, last_name, cvv2=nil, other_params={})
      do_direct_payment('Authorization', ipaddress, amount, credit_card_type, credit_card_no,
                        expiry_date, first_name, last_name, cvv2, other_params)
    end

    # Performs credit card payment with PayPal, finalizing the sale. Funds are captured immediately.
    # Calls do_direct_payment.
    #
    # Equivalent of DoDirectPayment with the PAYMENTACTION of 'sale'
    #
    def do_direct_payment_sale(ipaddress, amount, credit_card_type, credit_card_no, expiry_date,
                               first_name, last_name, cvv2=nil, other_params={})
      do_direct_payment('Sale', ipaddress, amount, credit_card_type, credit_card_no,
                        expiry_date, first_name, last_name, cvv2, other_params)
    end

    # Performs credit card payment with PayPal.
    #
    # Equivalent of DoDirectPayment.
    #
    # Performs Luhn check and a simple credit card type check based on the card number.
    #
    def do_direct_payment(payment_action, ipaddress, amount, credit_card_type,
      credit_card_no, expiry_date, first_name, last_name, cvv2=nil, other_params={})
      params = {
        'METHOD' => 'DoDirectPayment',
        'PAYMENTACTION' => payment_action,
        'AMT' => amount.to_s,
        'CREDITCARDTYPE' => credit_card_type,
        'ACCT' => credit_card_no,
        'EXPDATE' => expiry_date,
        'FIRSTNAME' => first_name,
        'LASTNAME' => last_name,
        'IPADDRESS' => ipaddress }
        params['CVV2'] = cvv2 unless cvv2.nil?
        params.merge! other_params

        raise 'Invalid credit card number' if not luhn_check(params['ACCT'])
        raise 'Invalid credit card type' if not card_type_check(params['CREDITCARDTYPE'], params['ACCT'])

        make_nvp_call(params)
      end

      # Performs payment through PayPal.
      #
      # Equivalent of SetExpressCheckout.
      #
      def do_set_express_checkout(return_url, cancel_url, amount, other_params={})
		return set_express_checkout(return_url, cancel_url, amount, other_params)
	  end

      def set_express_checkout(return_url, cancel_url, amount, other_params={})
        params = {
          'METHOD' => 'SetExpressCheckout',
          'RETURNURL' => return_url,
          'CANCELURL' => cancel_url,
#           'AMT' => amount.to_s # AMT is deprecated in version 63. AK 1/8/2011
          'PAYMENTREQUEST_0_AMT' => amount.to_s
        }
        params.merge! other_params
        make_nvp_call(params)
      end

      # Gets the details of the request started through set_express_checkout.
      #
      # Equivalent of GetExpressCheckoutDetails.
      #
      def get_express_checkout_details(token)
        params = {
          'METHOD' => 'GetExpressCheckoutDetails',
          'TOKEN' => token
        }
        make_nvp_call(params)
      end

      #
      # Gets payment through PayPal for Express Checkout.
      #
      # Equivalent of DoExpressCheckoutPayment
      #
      def do_express_checkout_payment(token, payment_action, payer_id, amount, other_params={})
        params = {
          'METHOD' => 'DoExpressCheckoutPayment',
          'TOKEN' => token,
          'PAYMENTACTION' => payment_action,
          'PAYERID' => payer_id,
          'AMT' => amount
        }

        params.merge! other_params
        make_nvp_call(params)
      end

      #
      # Does authorization of a request.
      #
      # Equivalent of DoAuthorization.
      #
      def do_authorization(transaction_id, amount, currency_code = 'USD')
        params = {
          'METHOD' => 'DoAuthorization',
          'TRANSACTIONID' => transaction_id,
          'AMT' => amount.to_s,
          'TRANSACTIONENTITY' => 'Order',
          'CURRENCYCODE' => currency_code
        }
        make_nvp_call(params)
      end

      #
      # Captures payment for a transaction.
      #
      # Equivalent of DoCapture.
      #
      def do_capture(authorization_id, amount, complete=true, currency_code='USD', invoice_no=nil, note=nil, soft_descriptor=nil)
        params = {
          'METHOD' => 'DoCapture',
          'AUTHORIZATIONID' => authorization_id,
          'AMT' => amount.to_s,
          'CURRENCYCODE' => currency_code
        }
        if complete then
          params['COMPLETETYPE'] = 'Complete'
        else
          params['COMPLETETYPE'] = 'NotComplete'
        end
        params['INVNUM'] = invoice_no unless invoice_no.nil?
        params['NOTE'] = note unless note.nil?
        params['SOFTDESCRIPTOR'] = soft_descriptor unless soft_descriptor.nil?
        make_nvp_call(params)
      end

      #
      # Re-authorizes an authorized transaction.
      #
      # Equivalent of DoReauthorization.
      #
      def do_reauthorization(authorization_id, amount, currency_code = 'USD')
        params = {
          'METHOD' => 'DoReauthorization',
          'AUTHORIZATIONID' => authorization_id,
          'AMT' => amount.to_s,
          'CURRENCYCODE' => currency_code
        }
        make_nvp_call(params)
      end

      #
      # Makes the call to the PayPal NVP API. This is the workhorse method for the other method calls.
      #
      def make_nvp_call(params)
		pp params if @@debug

        @api_parameters.merge! params

        response = Net::HTTPS.post_form(URI.parse(@paypal_url), @api_parameters)
        response.error! unless response.kind_of? Net::HTTPSuccess
        PayPalResponse.new.merge get_hash(response.body)
      end

      #
      # Checks and returns information on the card based on the given BIN (Bank Identification Number).
      # Currently inactive since bindatabase.com is down.
      #
      def bin_check(bin)
        # stub for check to bindatabase.com, currently down
      end


      # Perform mass payment to a group of recipients
      #
      # Equivalent to MassPay
      #
      def do_mass_payment(payments, email_subject, receiver_type='EmailAddress', currency_code='USD')
        if receiver_type != 'EmailAddress' then
          receiver_type = 'UserID'
        end

        params = {
          'METHOD' => 'MassPay',
          'RECEIVERTYPE' => receiver_type,
          'CURRENCYCODE' => currency_code,
          'EMAILSUBJECT' => email_subject
        }

        payments.each_index { |num|
          if receiver_type == 'EmailAddress' then
            params["L_EMAIL#{num}"] = payments[num].email
          else
            params["L_RECEIVERID#{num}"] = payments[num].receiver_id
          end
          params["L_UNIQUEID#{num}"] = payments[num].unique_id
          params["L_NOTE#{num}"] = payments[num].note
          params["L_AMT#{num}"] = payments[num].amount
        }

        make_nvp_call(params)
      end

	 # techarch> Subscription APIs

    # Creates a payment subscription based on a start date, billing period, frequency, number of periods and amount
    #
    # Equivalent to CreateRecurringPaymentsProfile
    #
    def do_create_recurring_payments_profile(token, start_date, profile_reference, description, billing_period, billing_frequency, total_billing_cycles, amount, currency, other_params={})
      params = {
        'METHOD' => 'CreateRecurringPaymentsProfile',
        'TOKEN' => token,
		'PROFILESTARTDATE' => start_date,
		'PROFILEREFERENCE' => profile_reference,
		'DESC' => description,
		'BILLINGPERIOD' => billing_period,
		'BILLINGFREQUENCY' => billing_frequency,
		'TOTALBILLINGCYCLES' => total_billing_cycles,
		'AMT' => amount,
		'CURRENCYCODE' => currency
		}
        params.merge! other_params

        make_nvp_call(params)
     end

    # Retrieves the details of a payment subscription for a given profile id
	# Will return for e.g. the  start date, billing period, frequency, number of periods and amount
    #
    # Equivalent to GetRecurringPaymentsProfileDetails
    #
    def do_get_recurring_payments_profile_details (profile_id, other_params={})
      params = {
        'METHOD' => 'GetRecurringPaymentsProfileDetails',
        'PROFILEID' => profile_id }
        params.merge! other_params

        make_nvp_call(params)
    end

    # Manages a recurring subscription profile in terms of status:
    #   - Cancel
	#   - Suspend
	#   - Reactivate
    # Equivalent to ManageRecurringPaymentsProfileStatus
    #
	def do_manage_recurring_payments_profile_status(profile_id, action, note='', other_params={})
      params = {
        'METHOD' => 'ManageRecurringPaymentsProfileStatus',
        'PROFILEID' => profile_id,
		'ACTION' => action,
		'NOTE' => note
		}
        params.merge! other_params

        make_nvp_call(params)
	end

    # Retrieves the customer details for the billing agreement associated with the current token
    # Equivalent to GetBillingAgreementCustomerDetails
    #
	def do_get_billing_agreement_customer_details(token, other_params={})
      params = {
        'METHOD' => 'GetBillingAgreementCustomerDetails',
        'TOKEN' => token
		}
        params.merge! other_params

        make_nvp_call(params)
	end

    # Initiates the creation of a billing agreement
    # Equivalent to SetCustomerBillingAgreement
    #
	def do_set_billing_agreement_customer_details(return_url, cancel_url, billing_desc, billing_type='RecurringPayments', payment_type='', custom='', other_params={})
      params = {
        'METHOD' => 'SetCustomerBillingAgreement',
			'RETURNURL' => return_url,
			'CANCELURL' => cancel_url,
			'L_BILLINGAGREEMENTDESCRIPTION0' => billing_desc,
			'L_BILLINGTYPE0' => billing_type,
			'L_PAYMENTTYPE0' => payment_type,
			'L_BILLINGAGREEMENTCUSTOM0' => custom
		}
        params.merge! other_params

        make_nvp_call(params)
	end

    # Retrieves the details of a transaction for a given transaction id
    #
    # Equivalent to GetTransactionDetails
    #
    def do_get_transaction_details (transaction_id, other_params={})
      params = {
        'METHOD' => 'GetTransactionDetails',
        'TRANSACTIONID' => transaction_id }
        params.merge! other_params

        make_nvp_call(params)
    end

    # Retrieves the details of a express checkout for a given token
    #
    # Equivalent to GetExpressCheckoutDetails
    #
    def do_get_express_checkout_details (token, other_params={})
      params = {
        'METHOD' => 'GetExpressCheckoutDetails',
        'TOKEN' => token }
        params.merge! other_params

        make_nvp_call(params)
      end

    # Search transactions between payee and payer
    # Equivalent to TransactionSearch
    #
	def do_transaction_search(start_date,payee_email, payer_email='', payer_first='', payer_middle='', payer_last='',
												transaction_class='Subscription', other_params={})
      params = {
        'METHOD' => 'TransactionSearch',
			'STARTDATE' => start_date,
			'RECEIVER' => payee_email,
			'TRANSACTIONCLASS' => transaction_class
		}

		if !payer_email.nil? && !payer_email.empty?
			params['EMAIL'] = payer_email
		else
			params['FIRSTNAME'] 		= payer_first		!payer_first.nil? && !payer_first.empty?
			params['MIDDLENAME']	= payer_middle	!payer_middle.nil? && !payer_middle.empty?
			params['LASTNAME'] 		= payer_last		!payer_last.nil? && !payer_last.empty?
		end

        params.merge! other_params

        make_nvp_call(params)
	end

	# --------------------------------------------------------------------------------------------------------------------------------------

      private

      #
      # Gets a hash from a string, with a set of name value pairs joined by '='
      # and concatenated with '&'
      #
      def get_hash(string)
        hash = {}
        string.split('&').collect { |pair| pair.split('=') }.each { |a|
          hash[a[0]] = URI.unescape(a[1])
        }
        return hash
      end

    end
