#Ruby on Rails PayPal Plugin v1.0
#Copyright (C) 2006  Andre Price, ELC Technologies

#This library is free software; you can redistribute it and/or
#modify it under the terms of the GNU Lesser General Public
#License as published by the Free Software Foundation; either
#version 2.1 of the License, or (at your option) any later version.
#
#This library is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#Lesser General Public License for more details.
#
#You should have received a copy of the GNU Lesser General Public
#License along with this library; if not, write to the Free Software
#Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

# PayPal Plugin-
# ----------------------
# This plugin implements a directcharge method accessed with Paypal.directcharge(params).
# It currently has 3 functions
# * directcharge
# * directauth
# * capture

require 'defaultDriver.rb'
require 'soap/header/simplehandler'
require 'pp'
# Requester CredentialsHander ==  internal class used to communicate with paypal api
class RequesterCredentialsHandler < SOAP::Header::SimpleHandler
  HeaderName = XSD::QName.new('urn:ebay:api:PayPalAPI', 'RequesterCredentials')
  CredentialsName = XSD::QName.new('urn:ebay:apis:eBLBaseComponents', 'Credentials')
  UsernameName = XSD::QName.new(nil, 'Username')
  PasswordName = XSD::QName.new(nil, 'Password')
  SubjectName = XSD::QName.new(nil, 'Subject')

  def initialize(username, password, subject)
    super(HeaderName)
    @username, @password, @subject = username, password, subject
  end

  def on_simple_outbound
    {CredentialsName => {UsernameName => @username, PasswordName => @password, SubjectName => @subject}}
  end
end

class Paypal

=begin rdocdd
Create the paypal client to communicate with the paypal web services api.
Internaly used function
=end
  def Paypal.create_client
    environment = ENV['RAILS_ENV']
    live = (environment == 'production')
    app_root = File.dirname(__FILE__) + '/../../../..'
    config_dir = app_root + '/config'
      
    prefs = File.expand_path(config_dir + '/paypal.yml')
    if File.exists?(prefs)
      y = YAML.load(File.open(prefs))
      y.each {|pref, value| eval("@#{pref} =\"#{value}\"")}
      y[environment].each {|pref, value| eval("@#{pref} =\"#{value}\"")}
    end

    if live
      client = PayPalAPIAAInterface.new("https://api.paypal.com/2.0/")
    else
      client = PayPalAPIAAInterface.new()
    end
    
    client.options['protocol.http.ssl_config.verify_mode'] = OpenSSL::SSL::VERIFY_PEER
    client.options['protocol.http.ssl_config.ca_file'] = "#{File.expand_path(config_dir)+'/'+@ca_file}"
    client.options['protocol.http.ssl_config.client_cert'] = "#{File.expand_path(config_dir)+'/'+@client_cert}"
    client.options['protocol.http.ssl_config.client_key'] = "#{File.expand_path(config_dir)+'/'+@client_keys}"
    client.headerhandler << RequesterCredentialsHandler.new(@paypal_username, @paypal_password,'')
    
    # run ruby with -d to see SOAP wiredumps.
    client.wiredump_dev = STDERR if $DEBUG
    return client
  end

  def Paypal.express_checkout_redirect_url(token)
    live = ENV['RAILS_ENV'] == 'production'
    if live
      return "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{token}"
    else
      return "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{token}"
    end
  end
  
  def Paypal.express_checkout(params)
    details = SetExpressCheckoutRequestDetailsType.new
    #     details.orderTotal = Paypal._usd_amount(params[:amount])
    a = BasicAmountType.new(String(params[:amount]))
    a.xmlattr_currencyID = 'USD'
    details.orderTotal = a

    details.cancelURL = params[:cancelURL]
    details.returnURL = params[:returnURL]
    details.noShipping = params[:noShipping]
    details.cpp_header_image = params[:cpp_header_image]
    
    reqtype = SetExpressCheckoutRequestType.new
    reqtype.version = '2.0'
    reqtype.setExpressCheckoutRequestDetails = details
    req = SetExpressCheckoutReq.new(reqtype)

    return create_client().setExpressCheckout(req)
  end

  def Paypal.express_checkout_details(params)
    reqtype = GetExpressCheckoutDetailsRequestType.new
    reqtype.version = '2.0'
    reqtype.token = params[:token]
    req = GetExpressCheckoutDetailsReq.new(reqtype)
    return create_client().getExpressCheckoutDetails(req)
  end

  def Paypal.express_checkout_payment(params)
    details = DoExpressCheckoutPaymentRequestDetailsType.new
    details.token = params[:token]
    details.paymentAction = params[:paymentAction] || 'Sale'
    details.payerID = params[:payerID]
    details.paymentDetails = PaymentDetailsType.new
    details.paymentDetails.orderTotal = _usd_amount(params[:amount])
    
    reqtype = DoExpressCheckoutPaymentRequestType.new
    reqtype.version = '2.0'
    reqtype.doExpressCheckoutPaymentRequestDetails = details
    req = DoExpressCheckoutPaymentReq.new(reqtype)
    return create_client().doExpressCheckoutPayment(req)
  end
    
=begin rdoc
Function: directcharge
  This function performs a doDirectCharge action.  Transfering funds from the parameter's account to your paypal merchant account.

  The return value of this function is either "Success" or "Failure"  depending on validity of input.

  The directcharge method takes a hash argument (params).
  The method expects the hash to be in the form of:
               :firstName => "xxxx",
               :lastName => "xxxxxx",
               :ip => "127.0.0.1",
               :amount => "10,000",
               :itemName => "Item",
               :addressName => "Home",
               :street1 => "<STREET 1 of BILLING ADDRESS",
               :street2 => "<STREET 2 OF Billing address (optional)",
               :cityName => "<City name of billing address>",
               :postalCode =>  "<Postal code for billing address>",
               :stateOrProvince => "<State of billing address>",
               :country => "<Country Code for billing address (ex US)",
               :creditCardType => "<Credit Card type (Visa, MasterCard, Amex, Discover)>",
               :creditCardNumber => "<Buyers credit card number>",
               :cVV2 => "<Authorization number (last 3 digits on back of ccard>"
               :expMonth => 7,//example
               :expYear => 2999 //example
=end

  def Paypal.directcharge(params)

    client = create_client()

    directreq = DoDirectPaymentReq.new
    drtype = DoDirectPaymentRequestType.new
    directreq.doDirectPaymentRequest = drtype
    drtype.version = "2.0"
    dtype = DoDirectPaymentRequestDetailsType.new
    dtype.iPAddress = params[:ip]

    pdetails = PaymentDetailsType.new
    pdetails.orderTotal = _usd_amount(params[:amount])
    dtype.paymentDetails = pdetails

    drtype.doDirectPaymentRequestDetails = dtype
    dcard = CreditCardDetailsType.new
    dtype.paymentAction = "Sale"
    payerinfo = PayerInfoType.new
    addr = AddressType.new
    addr.name = params[:addressName]
    addr.street1 = params[:street1]
    addr.street2 = params[:street2]
    addr.cityName = params[:cityName]
    addr.postalCode = params[:postalCode]
    addr.stateOrProvince = params[:stateOrProvince]
    addr.country = params[:country]
    dcard.creditCardType = params[:creditCardType]
    dcard.creditCardNumber =  params[:creditCardNumber]
    if (params[:cVV2]==nil)
        dcard.cVV2 = "000"
    else
        dcard.cVV2 =  params[:cVV2]
    end
    dcard.expMonth = params[:expMonth]
    dcard.expYear  = params[:expYear]
    pname = PersonNameType.new
    pname.firstName = params[:firstName]
    pname.lastName = params[:lastName]
    payerinfo.payerName = pname
    paydetailssitem = PaymentDetailsItemType.new
    paydetailssitem.name = params[:itemName]
    dtype.creditCard = dcard
    dcard.cardOwner = payerinfo
    payerinfo.address = addr
    pdetails.shipToAddress = addr
    res = client.doDirectPayment(directreq)
    puts res.ack if $DEBUG
    #res.ack
    return res
  end
=begin rdoc
Function: directauth
  This function performs a directcharge in authorization mode.  This means no actual funds are
  transfered upon comletetion of this action.

  The return value of this function is either "Failure" or the transactionID for the authorization.
  The transactionID is needed if you intend to capture the funds authroized by this function.
  The method expects the param hash to be in the form of :
               :firstName => "<FIRST_NAME_VALUE>",
               :lastName => "<LAST_NAME_VALUE>",
               :ip => "<BUYERS_IP_ADDRESS",
               :amount => "<AMOUNT_TO_CHARGE>",    //This value has a maximum of 10,000.00
               :itemName => "<ITEM_THAT_IS_BEING_SOLD",
               :addressName => "Billing",
               :street1 => "<FIRST LINE OF STREET ADDRESS>",
               :street2 => "<SECOND LINE OF STREET ADDRESS>",
               :cityName => "<CITY OF BILLING ADDRESS OF CARD>",
               :postalCode =>  "<ZIPCODE OF BILLING ADDRESS OF CARD>",
               :stateOrProvince => "<STATECODE OF BILLING ADDRESS>",
               :country => "<COUNTRY CODE OF BILLING ADDRESS>",
               :creditCardType => "Visa or MasterCard or Amex or Discover",
               :creditCardNumber => "<VALID CREDIT CARD NUMBER",
               :cVV2 => "<CVV2 AUTHORIZATION NUMBER FROM CARD"
               :expMonth => 1  ,  //Expiration month in numerical form not string
               :expYear => 2006     ///Expiration year in numerical form

=end
  def Paypal.directauth(params)
    client = create_client()

    directreq = DoDirectPaymentReq.new
    drtype = DoDirectPaymentRequestType.new
    directreq.doDirectPaymentRequest = drtype
    drtype.version = "2.0"
    dtype = DoDirectPaymentRequestDetailsType.new
    dtype.iPAddress = params[:ip]

    pdetails = PaymentDetailsType.new
    pdetails.orderTotal = _usd_amount(params[:amount])
    dtype.paymentDetails = pdetails

    drtype.doDirectPaymentRequestDetails = dtype
    dcard = CreditCardDetailsType.new
    dtype.paymentAction = "Authorization"
    payerinfo = PayerInfoType.new
    addr = AddressType.new
    addr.name = params[:addressName]
    addr.street1 = params[:street1]
    addr.street2 = params[:street2]
    addr.cityName = params[:cityName]
    addr.postalCode = params[:postalCode]
    addr.stateOrProvince = params[:stateOrProvince]
    addr.country = params[:country]
    dcard.creditCardType = params[:creditCardType]
    dcard.creditCardNumber =  params[:creditCardNumber]
    if (params[:cVV2]==nil)
        dcard.cVV2 = "000"
    else
        dcard.cVV2 =  params[:cVV2]
    end
    dcard.expMonth = params[:expMonth]
    dcard.expYear  = params[:expYear]
    pname = PersonNameType.new
    pname.firstName = params[:firstName]
    pname.lastName = params[:lastName]
    payerinfo.payerName = pname
    paydetailssitem = PaymentDetailsItemType.new
    paydetailssitem.name = params[:itemName]
    dtype.creditCard = dcard
    dcard.cardOwner = payerinfo
    payerinfo.address = addr
    pdetails.shipToAddress = addr
    res = client.doDirectPayment(directreq)
    #puts res.ack
    #if res.ack == "Success"
#           return res.transactionID
#    else
#           return "Failure"
 #   end
     return res
  end

=begin rdoc
Function: capture

  This funcion performs a doCapture.  It captures or collects the charge from a previously authorized
  transaction.  This transaction is referenced by the transactionID returned from directauth.

  The return value of this function is either "Success" or "Failure"

  The parameter hash for this function is to be in the following form:
              :transactionID => "<RETURN FROM PREVIOUS DIRECT AUTH>"
              :amount = > "<AMOUNT TO CHARGE>" //should be less than or equal to
                                               //auth's amount
  **WARNING*** This function is currently not functioning correctly.  It throws NoMethodErrors even when successfuly making a capture.
      Even when running in debug mode with wiredumps the responses from paypal are have Ack values of Success.  Indicating an error in the parsing of the response outside this plugin.
=end
  def Paypal.capture(params)
    client = create_client()
    capturetype = DoCaptureRequestType.new
    capturetype.version = "2.0"
    capturereq = DoCaptureReq.new
    capturereq.doCaptureRequest = capturetype
    capturetype.authorizationID = params[:transactionID]
    capturetype.amount = _usd_amount(params[:amount])
    capturetype.completeType = "Complete"
    #begin
      res = client.doCapture(capturereq)
      #puts res.paymentStatus
      #return res.ack
      return res
    #rescue NoMethodError
      # puts "Error Caught, Status lost\n"
      # return "Failure"
    #end
  end
  def Paypal.authorize(params)
    client = create_client()
    authreqtype = DoAuthorizationRequestType.new
    authreqtype.version = "2.0"
    authreq = DoAuthorizationReq.new
    authreq.doAuthorizationRequest = authreqtype
    authreqtype.transactionID = params[:transactionID]
    authreqtype.amount = _usd_amount(params[:amount])
    res = client.doAuthorization(authreq)
    return res
  end
  def Paypal.reauthorize(params)
    client = create_client()
    reauthreqtype = DoReauthorizationRequestType.new
    reauthreqtype.version = "2.0"
    reauthreq = DoReauthorizationReq.new
    reauthreq.doReauthorizationRequest = reauthreqtype
    reauthreqtype.authorizationID = params[:transactionID]
    reauthreqtype.amount = _usd_amount(params[:amount])
    res = client.doReauthorization(reauthreq)
    return res
  end
  def Paypal.void(params)
    client = create_client()
    voidreqtype = DoVoidRequestType.new
    voidreqtype.version = "2.0"
    voidreq = DoVoidReq.new
    voidreq.doVoidRequest = voidreqtype
    voidreqtype.authorizationID = params[:transactionID]
    res = client.doVoid(voidreq)
    return res
  end

  private
  def Paypal._usd_amount(amount)
    a = BasicAmountType.new(String(amount))
    a.xmlattr_currencyID = 'USD'
    return a
  end
end
