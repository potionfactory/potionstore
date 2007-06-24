#!/usr/bin/env ruby
require 'defaultDriver.rb'

endpoint_url = ARGV.shift
obj = PayPalAPIInterface.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   RefundTransaction(refundTransactionRequest)
#
# ARGS
#   refundTransactionRequest RefundTransactionReq - {urn:ebay:api:PayPalAPI}RefundTransactionReq
#
# RETURNS
#   refundTransactionResponse RefundTransactionResponse - {urn:ebay:api:PayPalAPI}RefundTransactionResponse
#
refundTransactionRequest = nil
puts obj.refundTransaction(refundTransactionRequest)

# SYNOPSIS
#   GetTransactionDetails(getTransactionDetailsRequest)
#
# ARGS
#   getTransactionDetailsRequest GetTransactionDetailsReq - {urn:ebay:api:PayPalAPI}GetTransactionDetailsReq
#
# RETURNS
#   getTransactionDetailsResponse GetTransactionDetailsResponse - {urn:ebay:api:PayPalAPI}GetTransactionDetailsResponse
#
getTransactionDetailsRequest = nil
puts obj.getTransactionDetails(getTransactionDetailsRequest)

# SYNOPSIS
#   BillUser(billUserRequest)
#
# ARGS
#   billUserRequest BillUserReq - {urn:ebay:api:PayPalAPI}BillUserReq
#
# RETURNS
#   billUserResponse BillUserResponse - {urn:ebay:api:PayPalAPI}BillUserResponse
#
billUserRequest = nil
puts obj.billUser(billUserRequest)

# SYNOPSIS
#   TransactionSearch(transactionSearchRequest)
#
# ARGS
#   transactionSearchRequest TransactionSearchReq - {urn:ebay:api:PayPalAPI}TransactionSearchReq
#
# RETURNS
#   transactionSearchResponse TransactionSearchResponse - {urn:ebay:api:PayPalAPI}TransactionSearchResponse
#
transactionSearchRequest = nil
puts obj.transactionSearch(transactionSearchRequest)

# SYNOPSIS
#   MassPay(massPayRequest)
#
# ARGS
#   massPayRequest  MassPayReq - {urn:ebay:api:PayPalAPI}MassPayReq
#
# RETURNS
#   massPayResponse MassPayResponse - {urn:ebay:api:PayPalAPI}MassPayResponse
#
massPayRequest = nil
puts obj.massPay(massPayRequest)

# SYNOPSIS
#   BillAgreementUpdate(billAgreementUpdateRequest)
#
# ARGS
#   billAgreementUpdateRequest BillAgreementUpdateReq - {urn:ebay:api:PayPalAPI}BillAgreementUpdateReq
#
# RETURNS
#   body            BAUpdateResponse - {urn:ebay:api:PayPalAPI}BAUpdateResponse
#
billAgreementUpdateRequest = nil
puts obj.billAgreementUpdate(billAgreementUpdateRequest)

# SYNOPSIS
#   AddressVerify(addressVerifyRequest)
#
# ARGS
#   addressVerifyRequest AddressVerifyReq - {urn:ebay:api:PayPalAPI}AddressVerifyReq
#
# RETURNS
#   addressVerifyResponse AddressVerifyResponse - {urn:ebay:api:PayPalAPI}AddressVerifyResponse
#
addressVerifyRequest = nil
puts obj.addressVerify(addressVerifyRequest)

# SYNOPSIS
#   EnterBoarding(enterBoardingRequest)
#
# ARGS
#   enterBoardingRequest EnterBoardingReq - {urn:ebay:api:PayPalAPI}EnterBoardingReq
#
# RETURNS
#   enterBoardingResponse EnterBoardingResponse - {urn:ebay:api:PayPalAPI}EnterBoardingResponse
#
enterBoardingRequest = nil
puts obj.enterBoarding(enterBoardingRequest)

# SYNOPSIS
#   GetBoardingDetails(getBoardingDetailsRequest)
#
# ARGS
#   getBoardingDetailsRequest GetBoardingDetailsReq - {urn:ebay:api:PayPalAPI}GetBoardingDetailsReq
#
# RETURNS
#   getBoardingDetailsResponse GetBoardingDetailsResponse - {urn:ebay:api:PayPalAPI}GetBoardingDetailsResponse
#
getBoardingDetailsRequest = nil
puts obj.getBoardingDetails(getBoardingDetailsRequest)


endpoint_url = ARGV.shift
obj = PayPalAPIAAInterface.new(endpoint_url)

# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG

# SYNOPSIS
#   DoExpressCheckoutPayment(doExpressCheckoutPaymentRequest)
#
# ARGS
#   doExpressCheckoutPaymentRequest DoExpressCheckoutPaymentReq - {urn:ebay:api:PayPalAPI}DoExpressCheckoutPaymentReq
#
# RETURNS
#   doExpressCheckoutPaymentResponse DoExpressCheckoutPaymentResponse - {urn:ebay:api:PayPalAPI}DoExpressCheckoutPaymentResponse
#
doExpressCheckoutPaymentRequest = nil
puts obj.doExpressCheckoutPayment(doExpressCheckoutPaymentRequest)

# SYNOPSIS
#   SetExpressCheckout(setExpressCheckoutRequest)
#
# ARGS
#   setExpressCheckoutRequest SetExpressCheckoutReq - {urn:ebay:api:PayPalAPI}SetExpressCheckoutReq
#
# RETURNS
#   setExpressCheckoutResponse SetExpressCheckoutResponse - {urn:ebay:api:PayPalAPI}SetExpressCheckoutResponse
#
setExpressCheckoutRequest = nil
puts obj.setExpressCheckout(setExpressCheckoutRequest)

# SYNOPSIS
#   GetExpressCheckoutDetails(getExpressCheckoutDetailsRequest)
#
# ARGS
#   getExpressCheckoutDetailsRequest GetExpressCheckoutDetailsReq - {urn:ebay:api:PayPalAPI}GetExpressCheckoutDetailsReq
#
# RETURNS
#   getExpressCheckoutDetailsResponse GetExpressCheckoutDetailsResponse - {urn:ebay:api:PayPalAPI}GetExpressCheckoutDetailsResponse
#
getExpressCheckoutDetailsRequest = nil
puts obj.getExpressCheckoutDetails(getExpressCheckoutDetailsRequest)

# SYNOPSIS
#   DoDirectPayment(doDirectPaymentRequest)
#
# ARGS
#   doDirectPaymentRequest DoDirectPaymentReq - {urn:ebay:api:PayPalAPI}DoDirectPaymentReq
#
# RETURNS
#   doDirectPaymentResponse DoDirectPaymentResponse - {urn:ebay:api:PayPalAPI}DoDirectPaymentResponse
#
doDirectPaymentRequest = nil
puts obj.doDirectPayment(doDirectPaymentRequest)

# SYNOPSIS
#   DoCapture(doCaptureRequest)
#
# ARGS
#   doCaptureRequest DoCaptureReq - {urn:ebay:api:PayPalAPI}DoCaptureReq
#
# RETURNS
#   doCaptureResponse DoCaptureResponse - {urn:ebay:api:PayPalAPI}DoCaptureResponse
#
doCaptureRequest = nil
puts obj.doCapture(doCaptureRequest)

# SYNOPSIS
#   DoReauthorization(doReauthorizationRequest)
#
# ARGS
#   doReauthorizationRequest DoReauthorizationReq - {urn:ebay:api:PayPalAPI}DoReauthorizationReq
#
# RETURNS
#   doReauthorizationResponse DoReauthorizationResponse - {urn:ebay:api:PayPalAPI}DoReauthorizationResponse
#
doReauthorizationRequest = nil
puts obj.doReauthorization(doReauthorizationRequest)

# SYNOPSIS
#   DoVoid(doVoidRequest)
#
# ARGS
#   doVoidRequest   DoVoidReq - {urn:ebay:api:PayPalAPI}DoVoidReq
#
# RETURNS
#   doVoidResponse  DoVoidResponse - {urn:ebay:api:PayPalAPI}DoVoidResponse
#
doVoidRequest = nil
puts obj.doVoid(doVoidRequest)

# SYNOPSIS
#   DoAuthorization(doAuthorizationRequest)
#
# ARGS
#   doAuthorizationRequest DoAuthorizationReq - {urn:ebay:api:PayPalAPI}DoAuthorizationReq
#
# RETURNS
#   doAuthorizationResponse DoAuthorizationResponse - {urn:ebay:api:PayPalAPI}DoAuthorizationResponse
#
doAuthorizationRequest = nil
puts obj.doAuthorization(doAuthorizationRequest)


