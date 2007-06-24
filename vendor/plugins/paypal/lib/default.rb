require 'xsd/qname'

# {urn:ebay:api:PayPalAPI}RefundTransactionReq
class RefundTransactionReq
  @@schema_type = "RefundTransactionReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["refundTransactionRequest", ["RefundTransactionRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "RefundTransactionRequest")]]
  ]

  attr_accessor :refundTransactionRequest

  def initialize(refundTransactionRequest = nil)
    @refundTransactionRequest = refundTransactionRequest
  end
end

# {urn:ebay:api:PayPalAPI}GetTransactionDetailsReq
class GetTransactionDetailsReq
  @@schema_type = "GetTransactionDetailsReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["getTransactionDetailsRequest", ["GetTransactionDetailsRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "GetTransactionDetailsRequest")]]
  ]

  attr_accessor :getTransactionDetailsRequest

  def initialize(getTransactionDetailsRequest = nil)
    @getTransactionDetailsRequest = getTransactionDetailsRequest
  end
end

# {urn:ebay:api:PayPalAPI}BillUserReq
class BillUserReq
  @@schema_type = "BillUserReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["billUserRequest", ["BillUserRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "BillUserRequest")]]
  ]

  attr_accessor :billUserRequest

  def initialize(billUserRequest = nil)
    @billUserRequest = billUserRequest
  end
end

# {urn:ebay:api:PayPalAPI}TransactionSearchReq
class TransactionSearchReq
  @@schema_type = "TransactionSearchReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["transactionSearchRequest", ["TransactionSearchRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionSearchRequest")]]
  ]

  attr_accessor :transactionSearchRequest

  def initialize(transactionSearchRequest = nil)
    @transactionSearchRequest = transactionSearchRequest
  end
end

# {urn:ebay:api:PayPalAPI}MassPayReq
class MassPayReq
  @@schema_type = "MassPayReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["massPayRequest", ["MassPayRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "MassPayRequest")]]
  ]

  attr_accessor :massPayRequest

  def initialize(massPayRequest = nil)
    @massPayRequest = massPayRequest
  end
end

# {urn:ebay:api:PayPalAPI}BillAgreementUpdateReq
class BillAgreementUpdateReq
  @@schema_type = "BillAgreementUpdateReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["bAUpdateRequest", ["BAUpdateRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "BAUpdateRequest")]]
  ]

  attr_accessor :bAUpdateRequest

  def initialize(bAUpdateRequest = nil)
    @bAUpdateRequest = bAUpdateRequest
  end
end

# {urn:ebay:api:PayPalAPI}AddressVerifyReq
class AddressVerifyReq
  @@schema_type = "AddressVerifyReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["addressVerifyRequest", ["AddressVerifyRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "AddressVerifyRequest")]]
  ]

  attr_accessor :addressVerifyRequest

  def initialize(addressVerifyRequest = nil)
    @addressVerifyRequest = addressVerifyRequest
  end
end

# {urn:ebay:api:PayPalAPI}EnterBoardingReq
class EnterBoardingReq
  @@schema_type = "EnterBoardingReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["enterBoardingRequest", ["EnterBoardingRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "EnterBoardingRequest")]]
  ]

  attr_accessor :enterBoardingRequest

  def initialize(enterBoardingRequest = nil)
    @enterBoardingRequest = enterBoardingRequest
  end
end

# {urn:ebay:api:PayPalAPI}GetBoardingDetailsReq
class GetBoardingDetailsReq
  @@schema_type = "GetBoardingDetailsReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["getBoardingDetailsRequest", ["GetBoardingDetailsRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "GetBoardingDetailsRequest")]]
  ]

  attr_accessor :getBoardingDetailsRequest

  def initialize(getBoardingDetailsRequest = nil)
    @getBoardingDetailsRequest = getBoardingDetailsRequest
  end
end

# {urn:ebay:api:PayPalAPI}SetExpressCheckoutReq
class SetExpressCheckoutReq
  @@schema_type = "SetExpressCheckoutReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["setExpressCheckoutRequest", ["SetExpressCheckoutRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "SetExpressCheckoutRequest")]]
  ]

  attr_accessor :setExpressCheckoutRequest

  def initialize(setExpressCheckoutRequest = nil)
    @setExpressCheckoutRequest = setExpressCheckoutRequest
  end
end

# {urn:ebay:api:PayPalAPI}GetExpressCheckoutDetailsReq
class GetExpressCheckoutDetailsReq
  @@schema_type = "GetExpressCheckoutDetailsReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["getExpressCheckoutDetailsRequest", ["GetExpressCheckoutDetailsRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "GetExpressCheckoutDetailsRequest")]]
  ]

  attr_accessor :getExpressCheckoutDetailsRequest

  def initialize(getExpressCheckoutDetailsRequest = nil)
    @getExpressCheckoutDetailsRequest = getExpressCheckoutDetailsRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoExpressCheckoutPaymentReq
class DoExpressCheckoutPaymentReq
  @@schema_type = "DoExpressCheckoutPaymentReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doExpressCheckoutPaymentRequest", ["DoExpressCheckoutPaymentRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoExpressCheckoutPaymentRequest")]]
  ]

  attr_accessor :doExpressCheckoutPaymentRequest

  def initialize(doExpressCheckoutPaymentRequest = nil)
    @doExpressCheckoutPaymentRequest = doExpressCheckoutPaymentRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoDirectPaymentReq
class DoDirectPaymentReq
  @@schema_type = "DoDirectPaymentReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doDirectPaymentRequest", ["DoDirectPaymentRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoDirectPaymentRequest")]]
  ]

  attr_accessor :doDirectPaymentRequest

  def initialize(doDirectPaymentRequest = nil)
    @doDirectPaymentRequest = doDirectPaymentRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoCaptureReq
class DoCaptureReq
  @@schema_type = "DoCaptureReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doCaptureRequest", ["DoCaptureRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoCaptureRequest")]]
  ]

  attr_accessor :doCaptureRequest

  def initialize(doCaptureRequest = nil)
    @doCaptureRequest = doCaptureRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoReauthorizationReq
class DoReauthorizationReq
  @@schema_type = "DoReauthorizationReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doReauthorizationRequest", ["DoReauthorizationRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoReauthorizationRequest")]]
  ]

  attr_accessor :doReauthorizationRequest

  def initialize(doReauthorizationRequest = nil)
    @doReauthorizationRequest = doReauthorizationRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoVoidReq
class DoVoidReq
  @@schema_type = "DoVoidReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doVoidRequest", ["DoVoidRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoVoidRequest")]]
  ]

  attr_accessor :doVoidRequest

  def initialize(doVoidRequest = nil)
    @doVoidRequest = doVoidRequest
  end
end

# {urn:ebay:api:PayPalAPI}DoAuthorizationReq
class DoAuthorizationReq
  @@schema_type = "DoAuthorizationReq"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_qualified = "true"
  @@schema_element = [
    ["doAuthorizationRequest", ["DoAuthorizationRequestType", XSD::QName.new("urn:ebay:api:PayPalAPI", "DoAuthorizationRequest")]]
  ]

  attr_accessor :doAuthorizationRequest

  def initialize(doAuthorizationRequest = nil)
    @doAuthorizationRequest = doAuthorizationRequest
  end
end

# {urn:ebay:api:PayPalAPI}RefundTransactionRequestType
class RefundTransactionRequestType
  @@schema_type = "RefundTransactionRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]],
    ["refundType", ["RefundPurposeTypeCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "RefundType")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]],
    ["memo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Memo")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :transactionID
  attr_accessor :refundType
  attr_accessor :amount
  attr_accessor :memo

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, transactionID = nil, refundType = nil, amount = nil, memo = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @transactionID = transactionID
    @refundType = refundType
    @amount = amount
    @memo = memo
  end
end

# {urn:ebay:api:PayPalAPI}RefundTransactionResponseType
class RefundTransactionResponseType
  @@schema_type = "RefundTransactionResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["refundTransactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "RefundTransactionID")]],
    ["netRefundAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "NetRefundAmount")]],
    ["feeRefundAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "FeeRefundAmount")]],
    ["grossRefundAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "GrossRefundAmount")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :refundTransactionID
  attr_accessor :netRefundAmount
  attr_accessor :feeRefundAmount
  attr_accessor :grossRefundAmount

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, refundTransactionID = nil, netRefundAmount = nil, feeRefundAmount = nil, grossRefundAmount = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @refundTransactionID = refundTransactionID
    @netRefundAmount = netRefundAmount
    @feeRefundAmount = feeRefundAmount
    @grossRefundAmount = grossRefundAmount
  end
end

# {urn:ebay:api:PayPalAPI}GetTransactionDetailsRequestType
class GetTransactionDetailsRequestType
  @@schema_type = "GetTransactionDetailsRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :transactionID

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, transactionID = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @transactionID = transactionID
  end
end

# {urn:ebay:api:PayPalAPI}GetTransactionDetailsResponseType
class GetTransactionDetailsResponseType
  @@schema_type = "GetTransactionDetailsResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["paymentTransactionDetails", ["PaymentTransactionType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentTransactionDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :paymentTransactionDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, paymentTransactionDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @paymentTransactionDetails = paymentTransactionDetails
  end
end

# {urn:ebay:api:PayPalAPI}BillUserRequestType
class BillUserRequestType
  @@schema_type = "BillUserRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["merchantPullPaymentDetails", ["MerchantPullPaymentType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MerchantPullPaymentDetails")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :merchantPullPaymentDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, merchantPullPaymentDetails = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @merchantPullPaymentDetails = merchantPullPaymentDetails
  end
end

# {urn:ebay:api:PayPalAPI}BillUserResponseType
class BillUserResponseType
  @@schema_type = "BillUserResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["billUserResponseDetails", ["MerchantPullPaymentResponseType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BillUserResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :billUserResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, billUserResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @billUserResponseDetails = billUserResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}TransactionSearchRequestType
class TransactionSearchRequestType
  @@schema_type = "TransactionSearchRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["startDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:api:PayPalAPI", "StartDate")]],
    ["endDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:api:PayPalAPI", "EndDate")]],
    ["payer", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Payer")]],
    ["receiver", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Receiver")]],
    ["receiptID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "ReceiptID")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]],
    ["payerName", ["PersonNameType", XSD::QName.new("urn:ebay:api:PayPalAPI", "PayerName")]],
    ["auctionItemNumber", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuctionItemNumber")]],
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "InvoiceID")]],
    ["transactionClass", ["PaymentTransactionClassCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionClass")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]],
    ["currencyCode", ["CurrencyCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "CurrencyCode")]],
    ["status", ["PaymentTransactionStatusCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Status")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :startDate
  attr_accessor :endDate
  attr_accessor :payer
  attr_accessor :receiver
  attr_accessor :receiptID
  attr_accessor :transactionID
  attr_accessor :payerName
  attr_accessor :auctionItemNumber
  attr_accessor :invoiceID
  attr_accessor :transactionClass
  attr_accessor :amount
  attr_accessor :currencyCode
  attr_accessor :status

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, startDate = nil, endDate = nil, payer = nil, receiver = nil, receiptID = nil, transactionID = nil, payerName = nil, auctionItemNumber = nil, invoiceID = nil, transactionClass = nil, amount = nil, currencyCode = nil, status = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @startDate = startDate
    @endDate = endDate
    @payer = payer
    @receiver = receiver
    @receiptID = receiptID
    @transactionID = transactionID
    @payerName = payerName
    @auctionItemNumber = auctionItemNumber
    @invoiceID = invoiceID
    @transactionClass = transactionClass
    @amount = amount
    @currencyCode = currencyCode
    @status = status
  end
end

# {urn:ebay:api:PayPalAPI}TransactionSearchResponseType
class TransactionSearchResponseType
  @@schema_type = "TransactionSearchResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["paymentTransactions", ["PaymentTransactionSearchResultType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentTransactions")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :paymentTransactions

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, paymentTransactions = [])
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @paymentTransactions = paymentTransactions
  end
end

# {urn:ebay:api:PayPalAPI}MassPayRequestType
class MassPayRequestType
  @@schema_type = "MassPayRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["emailSubject", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "EmailSubject")]],
    ["receiverType", ["ReceiverInfoCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "ReceiverType")]],
    ["massPayItem", ["MassPayRequestItemType[]", XSD::QName.new("urn:ebay:api:PayPalAPI", "MassPayItem")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :emailSubject
  attr_accessor :receiverType
  attr_accessor :massPayItem

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, emailSubject = nil, receiverType = nil, massPayItem = [])
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @emailSubject = emailSubject
    @receiverType = receiverType
    @massPayItem = massPayItem
  end
end

# {urn:ebay:api:PayPalAPI}MassPayResponseType
class MassPayResponseType
  @@schema_type = "MassPayResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
  end
end

# {urn:ebay:api:PayPalAPI}MassPayRequestItemType
class MassPayRequestItemType
  @@schema_type = "MassPayRequestItemType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["receiverEmail", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "ReceiverEmail")]],
    ["receiverID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "ReceiverID")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]],
    ["uniqueId", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "UniqueId")]],
    ["note", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Note")]]
  ]

  attr_accessor :receiverEmail
  attr_accessor :receiverID
  attr_accessor :amount
  attr_accessor :uniqueId
  attr_accessor :note

  def initialize(receiverEmail = nil, receiverID = nil, amount = nil, uniqueId = nil, note = nil)
    @receiverEmail = receiverEmail
    @receiverID = receiverID
    @amount = amount
    @uniqueId = uniqueId
    @note = note
  end
end

# {urn:ebay:api:PayPalAPI}BAUpdateRequestType
class BAUpdateRequestType
  @@schema_type = "BAUpdateRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["mpID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "MpID")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Custom")]],
    ["desc", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Desc")]],
    ["mpStatus", ["MerchantPullStatusCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "MpStatus")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :mpID
  attr_accessor :custom
  attr_accessor :desc
  attr_accessor :mpStatus

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, mpID = nil, custom = nil, desc = nil, mpStatus = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @mpID = mpID
    @custom = custom
    @desc = desc
    @mpStatus = mpStatus
  end
end

# {urn:ebay:api:PayPalAPI}BAUpdateResponseType
class BAUpdateResponseType
  @@schema_type = "BAUpdateResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["bAUpdateResponseDetails", ["BAUpdateResponseDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BAUpdateResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :bAUpdateResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, bAUpdateResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @bAUpdateResponseDetails = bAUpdateResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}AddressVerifyRequestType
class AddressVerifyRequestType
  @@schema_type = "AddressVerifyRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["email", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Email")]],
    ["street", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Street")]],
    ["zip", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Zip")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :email
  attr_accessor :street
  attr_accessor :zip

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, email = nil, street = nil, zip = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @email = email
    @street = street
    @zip = zip
  end
end

# {urn:ebay:api:PayPalAPI}AddressVerifyResponseType
class AddressVerifyResponseType
  @@schema_type = "AddressVerifyResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["confirmationCode", ["AddressStatusCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "ConfirmationCode")]],
    ["streetMatch", ["MatchStatusCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "StreetMatch")]],
    ["zipMatch", ["MatchStatusCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "ZipMatch")]],
    ["countryCode", ["CountryCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "CountryCode")]],
    ["payPalToken", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "PayPalToken")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :confirmationCode
  attr_accessor :streetMatch
  attr_accessor :zipMatch
  attr_accessor :countryCode
  attr_accessor :payPalToken

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, confirmationCode = nil, streetMatch = nil, zipMatch = nil, countryCode = nil, payPalToken = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @confirmationCode = confirmationCode
    @streetMatch = streetMatch
    @zipMatch = zipMatch
    @countryCode = countryCode
    @payPalToken = payPalToken
  end
end

# {urn:ebay:api:PayPalAPI}EnterBoardingRequestType
class EnterBoardingRequestType
  @@schema_type = "EnterBoardingRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["enterBoardingRequestDetails", ["EnterBoardingRequestDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EnterBoardingRequestDetails")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :enterBoardingRequestDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, enterBoardingRequestDetails = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @enterBoardingRequestDetails = enterBoardingRequestDetails
  end
end

# {urn:ebay:api:PayPalAPI}EnterBoardingResponseType
class EnterBoardingResponseType
  @@schema_type = "EnterBoardingResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Token")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :token

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, token = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @token = token
  end
end

# {urn:ebay:api:PayPalAPI}GetBoardingDetailsRequestType
class GetBoardingDetailsRequestType
  @@schema_type = "GetBoardingDetailsRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Token")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :token

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, token = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @token = token
  end
end

# {urn:ebay:api:PayPalAPI}GetBoardingDetailsResponseType
class GetBoardingDetailsResponseType
  @@schema_type = "GetBoardingDetailsResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["getBoardingDetailsResponseDetails", ["GetBoardingDetailsResponseDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GetBoardingDetailsResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :getBoardingDetailsResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, getBoardingDetailsResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @getBoardingDetailsResponseDetails = getBoardingDetailsResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}SetExpressCheckoutRequestType
class SetExpressCheckoutRequestType
  @@schema_type = "SetExpressCheckoutRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["setExpressCheckoutRequestDetails", ["SetExpressCheckoutRequestDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SetExpressCheckoutRequestDetails")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :setExpressCheckoutRequestDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, setExpressCheckoutRequestDetails = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @setExpressCheckoutRequestDetails = setExpressCheckoutRequestDetails
  end
end

# {urn:ebay:api:PayPalAPI}SetExpressCheckoutResponseType
class SetExpressCheckoutResponseType
  @@schema_type = "SetExpressCheckoutResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Token")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :token

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, token = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @token = token
  end
end

# {urn:ebay:api:PayPalAPI}GetExpressCheckoutDetailsRequestType
class GetExpressCheckoutDetailsRequestType
  @@schema_type = "GetExpressCheckoutDetailsRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Token")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :token

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, token = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @token = token
  end
end

# {urn:ebay:api:PayPalAPI}GetExpressCheckoutDetailsResponseType
class GetExpressCheckoutDetailsResponseType
  @@schema_type = "GetExpressCheckoutDetailsResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["getExpressCheckoutDetailsResponseDetails", ["GetExpressCheckoutDetailsResponseDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GetExpressCheckoutDetailsResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :getExpressCheckoutDetailsResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, getExpressCheckoutDetailsResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @getExpressCheckoutDetailsResponseDetails = getExpressCheckoutDetailsResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}DoExpressCheckoutPaymentRequestType
class DoExpressCheckoutPaymentRequestType
  @@schema_type = "DoExpressCheckoutPaymentRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["doExpressCheckoutPaymentRequestDetails", ["DoExpressCheckoutPaymentRequestDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DoExpressCheckoutPaymentRequestDetails")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :doExpressCheckoutPaymentRequestDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, doExpressCheckoutPaymentRequestDetails = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @doExpressCheckoutPaymentRequestDetails = doExpressCheckoutPaymentRequestDetails
  end
end

# {urn:ebay:api:PayPalAPI}DoExpressCheckoutPaymentResponseType
class DoExpressCheckoutPaymentResponseType
  @@schema_type = "DoExpressCheckoutPaymentResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["doExpressCheckoutPaymentResponseDetails", ["DoExpressCheckoutPaymentResponseDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DoExpressCheckoutPaymentResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :doExpressCheckoutPaymentResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, doExpressCheckoutPaymentResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @doExpressCheckoutPaymentResponseDetails = doExpressCheckoutPaymentResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}DoDirectPaymentRequestType
class DoDirectPaymentRequestType
  @@schema_type = "DoDirectPaymentRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["doDirectPaymentRequestDetails", ["DoDirectPaymentRequestDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DoDirectPaymentRequestDetails")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :doDirectPaymentRequestDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, doDirectPaymentRequestDetails = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @doDirectPaymentRequestDetails = doDirectPaymentRequestDetails
  end
end

# {urn:ebay:api:PayPalAPI}DoDirectPaymentResponseType
class DoDirectPaymentResponseType
  @@schema_type = "DoDirectPaymentResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]],
    ["aVSCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AVSCode")]],
    ["cVV2Code", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "CVV2Code")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :amount
  attr_accessor :aVSCode
  attr_accessor :cVV2Code
  attr_accessor :transactionID

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, amount = nil, aVSCode = nil, cVV2Code = nil, transactionID = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @amount = amount
    @aVSCode = aVSCode
    @cVV2Code = cVV2Code
    @transactionID = transactionID
  end
end

# {urn:ebay:api:PayPalAPI}DoCaptureRequestType
class DoCaptureRequestType
  @@schema_type = "DoCaptureRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuthorizationID")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]],
    ["completeType", ["CompleteCodeType", XSD::QName.new("urn:ebay:api:PayPalAPI", "CompleteType")]],
    ["note", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Note")]],
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "InvoiceID")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :authorizationID
  attr_accessor :amount
  attr_accessor :completeType
  attr_accessor :note
  attr_accessor :invoiceID

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, authorizationID = nil, amount = nil, completeType = nil, note = nil, invoiceID = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @authorizationID = authorizationID
    @amount = amount
    @completeType = completeType
    @note = note
    @invoiceID = invoiceID
  end
end

# {urn:ebay:api:PayPalAPI}DoCaptureResponseType
class DoCaptureResponseType
  @@schema_type = "DoCaptureResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["doCaptureResponseDetails", ["DoCaptureResponseDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DoCaptureResponseDetails")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :doCaptureResponseDetails

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, doCaptureResponseDetails = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @doCaptureResponseDetails = doCaptureResponseDetails
  end
end

# {urn:ebay:api:PayPalAPI}DoReauthorizationRequestType
class DoReauthorizationRequestType
  @@schema_type = "DoReauthorizationRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuthorizationID")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :authorizationID
  attr_accessor :amount

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, authorizationID = nil, amount = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @authorizationID = authorizationID
    @amount = amount
  end
end

# {urn:ebay:api:PayPalAPI}DoReauthorizationResponseType
class DoReauthorizationResponseType
  @@schema_type = "DoReauthorizationResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuthorizationID")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :authorizationID

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, authorizationID = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @authorizationID = authorizationID
  end
end

# {urn:ebay:api:PayPalAPI}DoVoidRequestType
class DoVoidRequestType
  @@schema_type = "DoVoidRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuthorizationID")]],
    ["note", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "Note")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :authorizationID
  attr_accessor :note

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, authorizationID = nil, note = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @authorizationID = authorizationID
    @note = note
  end
end

# {urn:ebay:api:PayPalAPI}DoVoidResponseType
class DoVoidResponseType
  @@schema_type = "DoVoidResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "AuthorizationID")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :authorizationID

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, authorizationID = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @authorizationID = authorizationID
  end
end

# {urn:ebay:api:PayPalAPI}DoAuthorizationRequestType
class DoAuthorizationRequestType
  @@schema_type = "DoAuthorizationRequestType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]],
    ["transactionEntity", ["TransactionEntityType", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionEntity")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any
  attr_accessor :transactionID
  attr_accessor :transactionEntity
  attr_accessor :amount

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil, transactionID = nil, transactionEntity = nil, amount = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
    @transactionID = transactionID
    @transactionEntity = transactionEntity
    @amount = amount
  end
end

# {urn:ebay:api:PayPalAPI}DoAuthorizationResponseType
class DoAuthorizationResponseType
  @@schema_type = "DoAuthorizationResponseType"
  @@schema_ns = "urn:ebay:api:PayPalAPI"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:api:PayPalAPI", "TransactionID")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:api:PayPalAPI", "Amount")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any
  attr_accessor :transactionID
  attr_accessor :amount

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil, transactionID = nil, amount = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
    @transactionID = transactionID
    @amount = amount
  end
end

# {urn:ebay:apis:CoreComponentTypes}AmountType
#   contains SOAP::SOAPDouble
class AmountType < ::String
  @@schema_attribute = {
    XSD::QName.new(nil, "currencyID") => nil
  }

  def xmlattr_currencyID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "currencyID")]
  end

  def xmlattr_currencyID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "currencyID")] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:CoreComponentTypes}BasicAmountType
#   contains SOAP::SOAPString
class BasicAmountType < ::String
  @@schema_attribute = {
    XSD::QName.new(nil, "currencyID") => nil
  }

  def xmlattr_currencyID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "currencyID")]
  end

  def xmlattr_currencyID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "currencyID")] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:CoreComponentTypes}MeasureType
#   contains SOAP::SOAPDouble
class MeasureType < ::String
  @@schema_attribute = {
    XSD::QName.new(nil, "unit") => nil
  }

  def xmlattr_unit
    (@__xmlattr ||= {})[XSD::QName.new(nil, "unit")]
  end

  def xmlattr_unit=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "unit")] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:CoreComponentTypes}QuantityType
#   contains SOAP::SOAPDouble
class QuantityType < ::String
  @@schema_attribute = {
    XSD::QName.new(nil, "unit") => nil
  }

  def xmlattr_unit
    (@__xmlattr ||= {})[XSD::QName.new(nil, "unit")]
  end

  def xmlattr_unit=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "unit")] = value
  end

  def initialize(*arg)
    super
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}AccountEntryType
class AccountEntryType
  @@schema_type = "AccountEntryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["balance", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Balance")]],
    ["credit", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Credit")]],
    ["date", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Date")]],
    ["debit", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Debit")]],
    ["itemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemID")]],
    ["memo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Memo")]],
    ["refNumber", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RefNumber")]],
    ["accountEntryDetailsType", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AccountEntryDetailsType")]]
  ]

  attr_accessor :balance
  attr_accessor :credit
  attr_accessor :date
  attr_accessor :debit
  attr_accessor :itemID
  attr_accessor :memo
  attr_accessor :refNumber
  attr_accessor :accountEntryDetailsType

  def initialize(balance = nil, credit = nil, date = nil, debit = nil, itemID = nil, memo = nil, refNumber = nil, accountEntryDetailsType = nil)
    @balance = balance
    @credit = credit
    @date = date
    @debit = debit
    @itemID = itemID
    @memo = memo
    @refNumber = refNumber
    @accountEntryDetailsType = accountEntryDetailsType
  end
end

# {urn:ebay:apis:eBLBaseComponents}AdditionalAccountType
class AdditionalAccountType
  @@schema_type = "AdditionalAccountType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["balance", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Balance")]],
    ["currency", ["CurrencyCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Currency")]],
    ["accountCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AccountCode")]]
  ]

  attr_accessor :balance
  attr_accessor :currency
  attr_accessor :accountCode

  def initialize(balance = nil, currency = nil, accountCode = nil)
    @balance = balance
    @currency = currency
    @accountCode = accountCode
  end
end

# {urn:ebay:apis:eBLBaseComponents}PromotedItemType
class PromotedItemType
  @@schema_type = "PromotedItemType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["itemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemID")]],
    ["pictureURL", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PictureURL")]],
    ["position", "SOAP::SOAPInt"],
    ["promotionPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PromotionPrice")]],
    ["promotionPriceType", ["PromotionItemPriceTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PromotionPriceType")]],
    ["selectionType", ["PromotionItemSelectionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SelectionType")]],
    ["title", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Title")]],
    ["listingType", ["ListingTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingType")]]
  ]

  attr_accessor :itemID
  attr_accessor :pictureURL
  attr_accessor :position
  attr_accessor :promotionPrice
  attr_accessor :promotionPriceType
  attr_accessor :selectionType
  attr_accessor :title
  attr_accessor :listingType

  def initialize(itemID = nil, pictureURL = nil, position = nil, promotionPrice = nil, promotionPriceType = nil, selectionType = nil, title = nil, listingType = nil)
    @itemID = itemID
    @pictureURL = pictureURL
    @position = position
    @promotionPrice = promotionPrice
    @promotionPriceType = promotionPriceType
    @selectionType = selectionType
    @title = title
    @listingType = listingType
  end
end

# {urn:ebay:apis:eBLBaseComponents}CrossPromotionsType
class CrossPromotionsType
  @@schema_type = "CrossPromotionsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["itemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemID")]],
    ["primaryScheme", ["PromotionSchemeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PrimaryScheme")]],
    ["promotionMethod", ["PromotionMethodCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PromotionMethod")]],
    ["sellerID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerID")]],
    ["shippingDiscount", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingDiscount")]],
    ["sellerKey", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerKey")]],
    ["storeName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StoreName")]],
    ["promotedItem", ["PromotedItemType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PromotedItem")]]
  ]

  attr_accessor :itemID
  attr_accessor :primaryScheme
  attr_accessor :promotionMethod
  attr_accessor :sellerID
  attr_accessor :shippingDiscount
  attr_accessor :sellerKey
  attr_accessor :storeName
  attr_accessor :promotedItem

  def initialize(itemID = nil, primaryScheme = nil, promotionMethod = nil, sellerID = nil, shippingDiscount = nil, sellerKey = nil, storeName = nil, promotedItem = [])
    @itemID = itemID
    @primaryScheme = primaryScheme
    @promotionMethod = promotionMethod
    @sellerID = sellerID
    @shippingDiscount = shippingDiscount
    @sellerKey = sellerKey
    @storeName = storeName
    @promotedItem = promotedItem
  end
end

# {urn:ebay:apis:eBLBaseComponents}AccountSummaryType
class AccountSummaryType
  @@schema_type = "AccountSummaryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [ :choice,
    ["accountState", ["AccountStateCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AccountState")]],
    ["additionalAccount", ["AdditionalAccountType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AdditionalAccount")]],
    ["additionalAccountsCount", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AdditionalAccountsCount")]],
    ["amountPastDue", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AmountPastDue")]],
    ["bankAccountInfo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BankAccountInfo")]],
    ["bankModifyDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BankModifyDate")]],
    ["billingCycleDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BillingCycleDate")]],
    ["cCExp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CCExp")]],
    ["cCInfo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CCInfo")]],
    ["cCModifyDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CCModifyDate")]],
    ["currentBalance", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CurrentBalance")]],
    ["lastAmountPaid", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastAmountPaid")]],
    ["lastInvoiceAmount", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastInvoiceAmount")]],
    ["lastInvoiceDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastInvoiceDate")]],
    ["lastPaymentDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastPaymentDate")]],
    ["pastDue", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PastDue")]],
    ["paymentMethod", ["SellerPaymentMethodCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentMethod")]]
  ]

  attr_accessor :accountState
  attr_accessor :additionalAccount
  attr_accessor :additionalAccountsCount
  attr_accessor :amountPastDue
  attr_accessor :bankAccountInfo
  attr_accessor :bankModifyDate
  attr_accessor :billingCycleDate
  attr_accessor :cCExp
  attr_accessor :cCInfo
  attr_accessor :cCModifyDate
  attr_accessor :currentBalance
  attr_accessor :lastAmountPaid
  attr_accessor :lastInvoiceAmount
  attr_accessor :lastInvoiceDate
  attr_accessor :lastPaymentDate
  attr_accessor :pastDue
  attr_accessor :paymentMethod

  def initialize(accountState = nil, additionalAccount = [], additionalAccountsCount = nil, amountPastDue = nil, bankAccountInfo = nil, bankModifyDate = nil, billingCycleDate = nil, cCExp = nil, cCInfo = nil, cCModifyDate = nil, currentBalance = nil, lastAmountPaid = nil, lastInvoiceAmount = nil, lastInvoiceDate = nil, lastPaymentDate = nil, pastDue = nil, paymentMethod = nil)
    @accountState = accountState
    @additionalAccount = additionalAccount
    @additionalAccountsCount = additionalAccountsCount
    @amountPastDue = amountPastDue
    @bankAccountInfo = bankAccountInfo
    @bankModifyDate = bankModifyDate
    @billingCycleDate = billingCycleDate
    @cCExp = cCExp
    @cCInfo = cCInfo
    @cCModifyDate = cCModifyDate
    @currentBalance = currentBalance
    @lastAmountPaid = lastAmountPaid
    @lastInvoiceAmount = lastInvoiceAmount
    @lastInvoiceDate = lastInvoiceDate
    @lastPaymentDate = lastPaymentDate
    @pastDue = pastDue
    @paymentMethod = paymentMethod
  end
end

# {urn:ebay:apis:eBLBaseComponents}BuyerType
class BuyerType
  @@schema_type = "BuyerType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["shippingAddress", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingAddress")]]
  ]

  attr_accessor :shippingAddress

  def initialize(shippingAddress = nil)
    @shippingAddress = shippingAddress
  end
end

# {urn:ebay:apis:eBLBaseComponents}SellerType
class SellerType
  @@schema_type = "SellerType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["allowPaymentEdit", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AllowPaymentEdit")]],
    ["billingCurrency", ["CurrencyCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BillingCurrency")]],
    ["checkoutEnabled", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CheckoutEnabled")]],
    ["cIPBankAccountStored", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CIPBankAccountStored")]],
    ["goodStanding", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GoodStanding")]],
    ["liveAuctionAuthorized", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LiveAuctionAuthorized")]],
    ["merchandizingPref", ["MerchandizingPrefCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MerchandizingPref")]],
    ["qualifiesForB2BVAT", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "QualifiesForB2BVAT")]],
    ["sellerLevel", ["SellerLevelCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerLevel")]],
    ["sellerPaymentAddress", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerPaymentAddress")]],
    ["schedulingInfo", ["SchedulingInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SchedulingInfo")]],
    ["storeOwner", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StoreOwner")]],
    ["storeURL", ["SOAP::SOAPAnyURI", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StoreURL")]]
  ]

  attr_accessor :allowPaymentEdit
  attr_accessor :billingCurrency
  attr_accessor :checkoutEnabled
  attr_accessor :cIPBankAccountStored
  attr_accessor :goodStanding
  attr_accessor :liveAuctionAuthorized
  attr_accessor :merchandizingPref
  attr_accessor :qualifiesForB2BVAT
  attr_accessor :sellerLevel
  attr_accessor :sellerPaymentAddress
  attr_accessor :schedulingInfo
  attr_accessor :storeOwner
  attr_accessor :storeURL

  def initialize(allowPaymentEdit = nil, billingCurrency = nil, checkoutEnabled = nil, cIPBankAccountStored = nil, goodStanding = nil, liveAuctionAuthorized = nil, merchandizingPref = nil, qualifiesForB2BVAT = nil, sellerLevel = nil, sellerPaymentAddress = nil, schedulingInfo = nil, storeOwner = nil, storeURL = nil)
    @allowPaymentEdit = allowPaymentEdit
    @billingCurrency = billingCurrency
    @checkoutEnabled = checkoutEnabled
    @cIPBankAccountStored = cIPBankAccountStored
    @goodStanding = goodStanding
    @liveAuctionAuthorized = liveAuctionAuthorized
    @merchandizingPref = merchandizingPref
    @qualifiesForB2BVAT = qualifiesForB2BVAT
    @sellerLevel = sellerLevel
    @sellerPaymentAddress = sellerPaymentAddress
    @schedulingInfo = schedulingInfo
    @storeOwner = storeOwner
    @storeURL = storeURL
  end
end

# {urn:ebay:apis:eBLBaseComponents}FeeType
class FeeType
  @@schema_type = "FeeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["fee", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Fee")]]
  ]

  attr_accessor :name
  attr_accessor :fee

  def initialize(name = nil, fee = nil)
    @name = name
    @fee = fee
  end
end

# {urn:ebay:apis:eBLBaseComponents}FeesType
class FeesType < ::Array
  @@schema_element = [
    ["Fee", ["FeeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Fee")]]
  ]
end

# {urn:ebay:apis:eBLBaseComponents}ShippingCarrierDetailsType
class ShippingCarrierDetailsType
  @@schema_type = "ShippingCarrierDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["carrierShippingFee", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CarrierShippingFee")]],
    ["insuranceFee", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceFee")]],
    ["insuranceOption", ["InsuranceOptionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceOption")]],
    ["packagingHandlingCosts", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PackagingHandlingCosts")]],
    ["shippingRateErrorMessage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingRateErrorMessage")]],
    ["shippingService", ["ShippingServiceCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingService")]]
  ]

  attr_accessor :carrierShippingFee
  attr_accessor :insuranceFee
  attr_accessor :insuranceOption
  attr_accessor :packagingHandlingCosts
  attr_accessor :shippingRateErrorMessage
  attr_accessor :shippingService

  def initialize(carrierShippingFee = nil, insuranceFee = nil, insuranceOption = nil, packagingHandlingCosts = nil, shippingRateErrorMessage = nil, shippingService = nil)
    @carrierShippingFee = carrierShippingFee
    @insuranceFee = insuranceFee
    @insuranceOption = insuranceOption
    @packagingHandlingCosts = packagingHandlingCosts
    @shippingRateErrorMessage = shippingRateErrorMessage
    @shippingService = shippingService
  end
end

# {urn:ebay:apis:eBLBaseComponents}CalculatedShippingRateType
class CalculatedShippingRateType
  @@schema_type = "CalculatedShippingRateType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["originatingPostalCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OriginatingPostalCode")]],
    ["shippingIrregular", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingIrregular")]],
    ["carrierDetails", ["ShippingCarrierDetailsType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CarrierDetails")]],
    ["shippingPackage", ["ShippingPackageCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingPackage")]],
    ["weightMajor", ["MeasureType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "WeightMajor")]],
    ["weightMinor", ["MeasureType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "WeightMinor")]]
  ]

  attr_accessor :originatingPostalCode
  attr_accessor :shippingIrregular
  attr_accessor :carrierDetails
  attr_accessor :shippingPackage
  attr_accessor :weightMajor
  attr_accessor :weightMinor

  def initialize(originatingPostalCode = nil, shippingIrregular = nil, carrierDetails = [], shippingPackage = nil, weightMajor = nil, weightMinor = nil)
    @originatingPostalCode = originatingPostalCode
    @shippingIrregular = shippingIrregular
    @carrierDetails = carrierDetails
    @shippingPackage = shippingPackage
    @weightMajor = weightMajor
    @weightMinor = weightMinor
  end
end

# {urn:ebay:apis:eBLBaseComponents}FlatShippingRateType
class FlatShippingRateType
  @@schema_type = "FlatShippingRateType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["additionalShippingCosts", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AdditionalShippingCosts")]],
    ["flatShippingHandlingCosts", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FlatShippingHandlingCosts")]],
    ["insuranceFee", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceFee")]],
    ["insuranceOption", ["InsuranceOptionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceOption")]],
    ["shippingService", ["ShippingServiceCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingService")]]
  ]

  attr_accessor :additionalShippingCosts
  attr_accessor :flatShippingHandlingCosts
  attr_accessor :insuranceFee
  attr_accessor :insuranceOption
  attr_accessor :shippingService

  def initialize(additionalShippingCosts = nil, flatShippingHandlingCosts = nil, insuranceFee = nil, insuranceOption = nil, shippingService = nil)
    @additionalShippingCosts = additionalShippingCosts
    @flatShippingHandlingCosts = flatShippingHandlingCosts
    @insuranceFee = insuranceFee
    @insuranceOption = insuranceOption
    @shippingService = shippingService
  end
end

# {urn:ebay:apis:eBLBaseComponents}SalesTaxType
class SalesTaxType
  @@schema_type = "SalesTaxType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["salesTaxPercent", ["SOAP::SOAPFloat", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesTaxPercent")]],
    ["salesTaxState", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesTaxState")]],
    ["shippingIncludedInTax", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingIncludedInTax")]]
  ]

  attr_accessor :salesTaxPercent
  attr_accessor :salesTaxState
  attr_accessor :shippingIncludedInTax

  def initialize(salesTaxPercent = nil, salesTaxState = nil, shippingIncludedInTax = nil)
    @salesTaxPercent = salesTaxPercent
    @salesTaxState = salesTaxState
    @shippingIncludedInTax = shippingIncludedInTax
  end
end

# {urn:ebay:apis:eBLBaseComponents}ShippingDetailsType
class ShippingDetailsType
  @@schema_type = "ShippingDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["allowPaymentEdit", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AllowPaymentEdit")]],
    ["calculatedShippingRate", ["CalculatedShippingRateType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CalculatedShippingRate")]],
    ["changePaymentInstructions", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ChangePaymentInstructions")]],
    ["flatShippingRate", ["FlatShippingRateType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FlatShippingRate")]],
    ["insuranceTotal", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceTotal")]],
    ["insuranceWanted", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InsuranceWanted")]],
    ["paymentInstructions", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentInstructions")]],
    ["salesTax", ["SalesTaxType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesTax")]],
    ["sellerPostalCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerPostalCode")]]
  ]

  attr_accessor :allowPaymentEdit
  attr_accessor :calculatedShippingRate
  attr_accessor :changePaymentInstructions
  attr_accessor :flatShippingRate
  attr_accessor :insuranceTotal
  attr_accessor :insuranceWanted
  attr_accessor :paymentInstructions
  attr_accessor :salesTax
  attr_accessor :sellerPostalCode

  def initialize(allowPaymentEdit = nil, calculatedShippingRate = nil, changePaymentInstructions = nil, flatShippingRate = [], insuranceTotal = nil, insuranceWanted = nil, paymentInstructions = nil, salesTax = nil, sellerPostalCode = nil)
    @allowPaymentEdit = allowPaymentEdit
    @calculatedShippingRate = calculatedShippingRate
    @changePaymentInstructions = changePaymentInstructions
    @flatShippingRate = flatShippingRate
    @insuranceTotal = insuranceTotal
    @insuranceWanted = insuranceWanted
    @paymentInstructions = paymentInstructions
    @salesTax = salesTax
    @sellerPostalCode = sellerPostalCode
  end
end

# {urn:ebay:apis:eBLBaseComponents}SiteHostedPictureType
class SiteHostedPictureType
  @@schema_type = "SiteHostedPictureType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["pictureURL", ["SOAP::SOAPAnyURI[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PictureURL")]],
    ["photoDisplay", ["PhotoDisplayCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PhotoDisplay")]],
    ["galleryType", ["GalleryTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GalleryType")]]
  ]

  attr_accessor :pictureURL
  attr_accessor :photoDisplay
  attr_accessor :galleryType

  def initialize(pictureURL = [], photoDisplay = nil, galleryType = nil)
    @pictureURL = pictureURL
    @photoDisplay = photoDisplay
    @galleryType = galleryType
  end
end

# {urn:ebay:apis:eBLBaseComponents}VendorHostedPictureType
class VendorHostedPictureType
  @@schema_type = "VendorHostedPictureType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["pictureURL", ["SOAP::SOAPAnyURI", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PictureURL")]],
    ["galleryURL", ["SOAP::SOAPAnyURI", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GalleryURL")]],
    ["galleryType", ["GalleryTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GalleryType")]]
  ]

  attr_accessor :pictureURL
  attr_accessor :galleryURL
  attr_accessor :galleryType

  def initialize(pictureURL = nil, galleryURL = nil, galleryType = nil)
    @pictureURL = pictureURL
    @galleryURL = galleryURL
    @galleryType = galleryType
  end
end

# {urn:ebay:apis:eBLBaseComponents}ValType
class ValType
  @@schema_type = "ValType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "ValueID") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["valueLiteral", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ValueLiteral")]]
  ]

  attr_accessor :valueLiteral

  def xmlattr_ValueID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "ValueID")]
  end

  def xmlattr_ValueID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "ValueID")] = value
  end

  def initialize(valueLiteral = nil)
    @valueLiteral = valueLiteral
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}AttributeType
class AttributeType
  @@schema_type = "AttributeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "AttributeID") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["value", ["ValType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Value")]]
  ]

  attr_accessor :value

  def xmlattr_AttributeID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "AttributeID")]
  end

  def xmlattr_AttributeID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "AttributeID")] = value
  end

  def initialize(value = [])
    @value = value
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}AttributeSetType
class AttributeSetType
  @@schema_type = "AttributeSetType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "AttributeSetID") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["attribute", ["AttributeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Attribute")]]
  ]

  attr_accessor :attribute

  def xmlattr_AttributeSetID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "AttributeSetID")]
  end

  def xmlattr_AttributeSetID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "AttributeSetID")] = value
  end

  def initialize(attribute = [])
    @attribute = attribute
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}ListOfAttributeSetType
class ListOfAttributeSetType < ::Array
  @@schema_element = [
    ["AttributeSet", ["AttributeSetType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AttributeSet")]]
  ]
end

# {urn:ebay:apis:eBLBaseComponents}CategoryType
class CategoryType
  @@schema_type = "CategoryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["autoPayEnabled", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AutoPayEnabled")]],
    ["b2BVATEnabled", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "B2BVATEnabled")]],
    ["catalogEnabled", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CatalogEnabled")]],
    ["categoryID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CategoryID")]],
    ["categoryLevel", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CategoryLevel")]],
    ["categoryName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CategoryName")]],
    ["categoryParentID", ["SOAP::SOAPString[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CategoryParentID")]],
    ["categoryParentName", ["SOAP::SOAPString[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CategoryParentName")]],
    ["cSIDList", ["SOAP::SOAPString[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CSIDList")]],
    ["expired", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Expired")]],
    ["intlAutosFixedCat", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "IntlAutosFixedCat")]],
    ["leafCategory", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LeafCategory")]],
    ["virtual", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Virtual")]]
  ]

  attr_accessor :autoPayEnabled
  attr_accessor :b2BVATEnabled
  attr_accessor :catalogEnabled
  attr_accessor :categoryID
  attr_accessor :categoryLevel
  attr_accessor :categoryName
  attr_accessor :categoryParentID
  attr_accessor :categoryParentName
  attr_accessor :cSIDList
  attr_accessor :expired
  attr_accessor :intlAutosFixedCat
  attr_accessor :leafCategory
  attr_accessor :virtual

  def initialize(autoPayEnabled = nil, b2BVATEnabled = nil, catalogEnabled = nil, categoryID = nil, categoryLevel = nil, categoryName = nil, categoryParentID = [], categoryParentName = [], cSIDList = [], expired = nil, intlAutosFixedCat = nil, leafCategory = nil, virtual = nil)
    @autoPayEnabled = autoPayEnabled
    @b2BVATEnabled = b2BVATEnabled
    @catalogEnabled = catalogEnabled
    @categoryID = categoryID
    @categoryLevel = categoryLevel
    @categoryName = categoryName
    @categoryParentID = categoryParentID
    @categoryParentName = categoryParentName
    @cSIDList = cSIDList
    @expired = expired
    @intlAutosFixedCat = intlAutosFixedCat
    @leafCategory = leafCategory
    @virtual = virtual
  end
end

# {urn:ebay:apis:eBLBaseComponents}StorefrontType
class StorefrontType
  @@schema_type = "StorefrontType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["storeCategoryID", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StoreCategoryID")]],
    ["storeURL", ["SOAP::SOAPAnyURI", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StoreURL")]]
  ]

  attr_accessor :storeCategoryID
  attr_accessor :storeURL

  def initialize(storeCategoryID = nil, storeURL = nil)
    @storeCategoryID = storeCategoryID
    @storeURL = storeURL
  end
end

# {urn:ebay:apis:eBLBaseComponents}ListingDesignerType
class ListingDesignerType
  @@schema_type = "ListingDesignerType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["layoutID", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LayoutID")]],
    ["optimalPictureSize", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OptimalPictureSize")]],
    ["themeID", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ThemeID")]]
  ]

  attr_accessor :layoutID
  attr_accessor :optimalPictureSize
  attr_accessor :themeID

  def initialize(layoutID = nil, optimalPictureSize = nil, themeID = nil)
    @layoutID = layoutID
    @optimalPictureSize = optimalPictureSize
    @themeID = themeID
  end
end

# {urn:ebay:apis:eBLBaseComponents}CharityType
class CharityType
  @@schema_type = "CharityType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["charityName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CharityName")]],
    ["charityNumber", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CharityNumber")]],
    ["donationPercent", ["SOAP::SOAPFloat", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DonationPercent")]]
  ]

  attr_accessor :charityName
  attr_accessor :charityNumber
  attr_accessor :donationPercent

  def initialize(charityName = nil, charityNumber = nil, donationPercent = nil)
    @charityName = charityName
    @charityNumber = charityNumber
    @donationPercent = donationPercent
  end
end

# {urn:ebay:apis:eBLBaseComponents}SellingStatusType
class SellingStatusType
  @@schema_type = "SellingStatusType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["bidCount", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BidCount")]],
    ["bidIncrement", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BidIncrement")]],
    ["convertedCurrentPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedCurrentPrice")]],
    ["currentPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CurrentPrice")]],
    ["highBidder", ["UserType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HighBidder")]],
    ["leadCount", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LeadCount")]],
    ["minimumToBid", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MinimumToBid")]],
    ["quantitySold", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "QuantitySold")]],
    ["reserveMet", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReserveMet")]],
    ["secondChanceEligible", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SecondChanceEligible")]]
  ]

  attr_accessor :bidCount
  attr_accessor :bidIncrement
  attr_accessor :convertedCurrentPrice
  attr_accessor :currentPrice
  attr_accessor :highBidder
  attr_accessor :leadCount
  attr_accessor :minimumToBid
  attr_accessor :quantitySold
  attr_accessor :reserveMet
  attr_accessor :secondChanceEligible

  def initialize(bidCount = nil, bidIncrement = nil, convertedCurrentPrice = nil, currentPrice = nil, highBidder = nil, leadCount = nil, minimumToBid = nil, quantitySold = nil, reserveMet = nil, secondChanceEligible = nil)
    @bidCount = bidCount
    @bidIncrement = bidIncrement
    @convertedCurrentPrice = convertedCurrentPrice
    @currentPrice = currentPrice
    @highBidder = highBidder
    @leadCount = leadCount
    @minimumToBid = minimumToBid
    @quantitySold = quantitySold
    @reserveMet = reserveMet
    @secondChanceEligible = secondChanceEligible
  end
end

# {urn:ebay:apis:eBLBaseComponents}ReviseStatusType
class ReviseStatusType
  @@schema_type = "ReviseStatusType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["itemRevised", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemRevised")]],
    ["buyItNowAdded", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyItNowAdded")]],
    ["buyItNowLowered", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyItNowLowered")]],
    ["reserveLowered", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReserveLowered")]],
    ["reserveRemoved", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReserveRemoved")]]
  ]

  attr_accessor :itemRevised
  attr_accessor :buyItNowAdded
  attr_accessor :buyItNowLowered
  attr_accessor :reserveLowered
  attr_accessor :reserveRemoved

  def initialize(itemRevised = nil, buyItNowAdded = nil, buyItNowLowered = nil, reserveLowered = nil, reserveRemoved = nil)
    @itemRevised = itemRevised
    @buyItNowAdded = buyItNowAdded
    @buyItNowLowered = buyItNowLowered
    @reserveLowered = reserveLowered
    @reserveRemoved = reserveRemoved
  end
end

# {urn:ebay:apis:eBLBaseComponents}ListingDetailsType
class ListingDetailsType
  @@schema_type = "ListingDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["adult", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Adult")]],
    ["bindingAuction", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BindingAuction")]],
    ["checkoutEnabled", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CheckoutEnabled")]],
    ["convertedBuyItNowPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedBuyItNowPrice")]],
    ["convertedStartPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedStartPrice")]],
    ["convertedReservePrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedReservePrice")]],
    ["hasReservePrice", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HasReservePrice")]],
    ["regionName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RegionName")]],
    ["relistedItemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RelistedItemID")]],
    ["secondChanceOriginalItemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SecondChanceOriginalItemID")]],
    ["startTime", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StartTime")]],
    ["endTime", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EndTime")]],
    ["viewItemURL", ["SOAP::SOAPAnyURI", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ViewItemURL")]]
  ]

  attr_accessor :adult
  attr_accessor :bindingAuction
  attr_accessor :checkoutEnabled
  attr_accessor :convertedBuyItNowPrice
  attr_accessor :convertedStartPrice
  attr_accessor :convertedReservePrice
  attr_accessor :hasReservePrice
  attr_accessor :regionName
  attr_accessor :relistedItemID
  attr_accessor :secondChanceOriginalItemID
  attr_accessor :startTime
  attr_accessor :endTime
  attr_accessor :viewItemURL

  def initialize(adult = nil, bindingAuction = nil, checkoutEnabled = nil, convertedBuyItNowPrice = nil, convertedStartPrice = nil, convertedReservePrice = nil, hasReservePrice = nil, regionName = nil, relistedItemID = nil, secondChanceOriginalItemID = nil, startTime = nil, endTime = nil, viewItemURL = nil)
    @adult = adult
    @bindingAuction = bindingAuction
    @checkoutEnabled = checkoutEnabled
    @convertedBuyItNowPrice = convertedBuyItNowPrice
    @convertedStartPrice = convertedStartPrice
    @convertedReservePrice = convertedReservePrice
    @hasReservePrice = hasReservePrice
    @regionName = regionName
    @relistedItemID = relistedItemID
    @secondChanceOriginalItemID = secondChanceOriginalItemID
    @startTime = startTime
    @endTime = endTime
    @viewItemURL = viewItemURL
  end
end

# {urn:ebay:apis:eBLBaseComponents}ItemType
class ItemType
  @@schema_type = "ItemType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["applicationData", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ApplicationData")]],
    ["listOfAttributeSets", ["ListOfAttributeSetType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListOfAttributeSets")]],
    ["autoPay", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AutoPay")]],
    ["buyerProtection", ["BuyerProtectionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyerProtection")]],
    ["buyItNowPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyItNowPrice")]],
    ["charity", ["CharityType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Charity")]],
    ["country", ["CountryCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Country")]],
    ["crossPromotion", ["CrossPromotionsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CrossPromotion")]],
    ["currency", ["CurrencyCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Currency")]],
    ["description", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Description")]],
    ["escrow", ["EscrowCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Escrow")]],
    ["giftIcon", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GiftIcon")]],
    ["giftServices", ["GiftServicesCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GiftServices")]],
    ["hitCounter", ["HitCounterCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HitCounter")]],
    ["itemID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemID")]],
    ["listingDetails", ["ListingDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingDetails")]],
    ["listingDesigner", ["ListingDesignerType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingDesigner")]],
    ["listingDuration", ["ListingDurationCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingDuration")]],
    ["listingEnhancement", ["ListingEnhancementsCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingEnhancement")]],
    ["listingType", ["ListingTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ListingType")]],
    ["location", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Location")]],
    ["partnerCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PartnerCode")]],
    ["partnerName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PartnerName")]],
    ["paymentMethods", ["BuyerPaymentMethodCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentMethods")]],
    ["payPalEmailAddress", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayPalEmailAddress")]],
    ["primaryCategory", ["CategoryType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PrimaryCategory")]],
    ["privateListing", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PrivateListing")]],
    ["quantity", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Quantity")]],
    ["regionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RegionID")]],
    ["relistLink", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RelistLink")]],
    ["reservePrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReservePrice")]],
    ["reviseStatus", ["ReviseStatusType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReviseStatus")]],
    ["scheduleTime", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ScheduleTime")]],
    ["secondaryCategory", ["CategoryType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SecondaryCategory")]],
    ["siteHostedPicture", ["SiteHostedPictureType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SiteHostedPicture")]],
    ["seller", ["UserType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Seller")]],
    ["sellingStatus", ["SellingStatusType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellingStatus")]],
    ["shippingOption", ["ShippingOptionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingOption")]],
    ["shippingDetails", ["ShippingDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingDetails")]],
    ["shippingRegions", ["ShippingRegionCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingRegions")]],
    ["shippingTerms", ["ShippingTermsCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingTerms")]],
    ["site", ["SiteCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Site")]],
    ["startPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StartPrice")]],
    ["storefront", ["StorefrontType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Storefront")]],
    ["subTitle", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SubTitle")]],
    ["timeLeft", ["SOAP::SOAPDuration", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TimeLeft")]],
    ["title", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Title")]],
    ["uUID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "UUID")]],
    ["vATDetails", ["VATDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "VATDetails")]],
    ["vendorHostedPicture", ["VendorHostedPictureType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "VendorHostedPicture")]]
  ]

  attr_accessor :applicationData
  attr_accessor :listOfAttributeSets
  attr_accessor :autoPay
  attr_accessor :buyerProtection
  attr_accessor :buyItNowPrice
  attr_accessor :charity
  attr_accessor :country
  attr_accessor :crossPromotion
  attr_accessor :currency
  attr_accessor :description
  attr_accessor :escrow
  attr_accessor :giftIcon
  attr_accessor :giftServices
  attr_accessor :hitCounter
  attr_accessor :itemID
  attr_accessor :listingDetails
  attr_accessor :listingDesigner
  attr_accessor :listingDuration
  attr_accessor :listingEnhancement
  attr_accessor :listingType
  attr_accessor :location
  attr_accessor :partnerCode
  attr_accessor :partnerName
  attr_accessor :paymentMethods
  attr_accessor :payPalEmailAddress
  attr_accessor :primaryCategory
  attr_accessor :privateListing
  attr_accessor :quantity
  attr_accessor :regionID
  attr_accessor :relistLink
  attr_accessor :reservePrice
  attr_accessor :reviseStatus
  attr_accessor :scheduleTime
  attr_accessor :secondaryCategory
  attr_accessor :siteHostedPicture
  attr_accessor :seller
  attr_accessor :sellingStatus
  attr_accessor :shippingOption
  attr_accessor :shippingDetails
  attr_accessor :shippingRegions
  attr_accessor :shippingTerms
  attr_accessor :site
  attr_accessor :startPrice
  attr_accessor :storefront
  attr_accessor :subTitle
  attr_accessor :timeLeft
  attr_accessor :title
  attr_accessor :uUID
  attr_accessor :vATDetails
  attr_accessor :vendorHostedPicture

  def initialize(applicationData = nil, listOfAttributeSets = nil, autoPay = nil, buyerProtection = nil, buyItNowPrice = nil, charity = nil, country = nil, crossPromotion = nil, currency = nil, description = nil, escrow = nil, giftIcon = nil, giftServices = [], hitCounter = nil, itemID = nil, listingDetails = nil, listingDesigner = nil, listingDuration = nil, listingEnhancement = [], listingType = nil, location = nil, partnerCode = nil, partnerName = nil, paymentMethods = [], payPalEmailAddress = nil, primaryCategory = nil, privateListing = nil, quantity = nil, regionID = nil, relistLink = nil, reservePrice = nil, reviseStatus = nil, scheduleTime = nil, secondaryCategory = nil, siteHostedPicture = nil, seller = nil, sellingStatus = nil, shippingOption = nil, shippingDetails = nil, shippingRegions = [], shippingTerms = nil, site = nil, startPrice = nil, storefront = nil, subTitle = nil, timeLeft = nil, title = nil, uUID = nil, vATDetails = nil, vendorHostedPicture = nil)
    @applicationData = applicationData
    @listOfAttributeSets = listOfAttributeSets
    @autoPay = autoPay
    @buyerProtection = buyerProtection
    @buyItNowPrice = buyItNowPrice
    @charity = charity
    @country = country
    @crossPromotion = crossPromotion
    @currency = currency
    @description = description
    @escrow = escrow
    @giftIcon = giftIcon
    @giftServices = giftServices
    @hitCounter = hitCounter
    @itemID = itemID
    @listingDetails = listingDetails
    @listingDesigner = listingDesigner
    @listingDuration = listingDuration
    @listingEnhancement = listingEnhancement
    @listingType = listingType
    @location = location
    @partnerCode = partnerCode
    @partnerName = partnerName
    @paymentMethods = paymentMethods
    @payPalEmailAddress = payPalEmailAddress
    @primaryCategory = primaryCategory
    @privateListing = privateListing
    @quantity = quantity
    @regionID = regionID
    @relistLink = relistLink
    @reservePrice = reservePrice
    @reviseStatus = reviseStatus
    @scheduleTime = scheduleTime
    @secondaryCategory = secondaryCategory
    @siteHostedPicture = siteHostedPicture
    @seller = seller
    @sellingStatus = sellingStatus
    @shippingOption = shippingOption
    @shippingDetails = shippingDetails
    @shippingRegions = shippingRegions
    @shippingTerms = shippingTerms
    @site = site
    @startPrice = startPrice
    @storefront = storefront
    @subTitle = subTitle
    @timeLeft = timeLeft
    @title = title
    @uUID = uUID
    @vATDetails = vATDetails
    @vendorHostedPicture = vendorHostedPicture
  end
end

# {urn:ebay:apis:eBLBaseComponents}TransactionsType
class TransactionsType < ::Array
  @@schema_element = [
    ["Transaction", ["TransactionType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Transaction")]]
  ]
end

# {urn:ebay:apis:eBLBaseComponents}TransactionType
class TransactionType
  @@schema_type = "TransactionType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["amountPaid", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AmountPaid")]],
    ["buyer", ["UserType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Buyer")]],
    ["shippingDetails", ["ShippingDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingDetails")]],
    ["convertedAmountPaid", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedAmountPaid")]],
    ["convertedTransactionPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConvertedTransactionPrice")]],
    ["createdDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CreatedDate")]],
    ["depositType", ["DepositTypeCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DepositType")]],
    ["item", ["ItemType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Item")]],
    ["quantityPurchased", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "QuantityPurchased")]],
    ["shippingHandlingTotal", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingHandlingTotal")]],
    ["status", ["TransactionStatusType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Status")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TransactionID")]],
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AuthorizationID")]],
    ["transactionPrice", ["AmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TransactionPrice")]],
    ["vATPercent", ["SOAP::SOAPDecimal", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "VATPercent")]]
  ]

  attr_accessor :amountPaid
  attr_accessor :buyer
  attr_accessor :shippingDetails
  attr_accessor :convertedAmountPaid
  attr_accessor :convertedTransactionPrice
  attr_accessor :createdDate
  attr_accessor :depositType
  attr_accessor :item
  attr_accessor :quantityPurchased
  attr_accessor :shippingHandlingTotal
  attr_accessor :status
  attr_accessor :transactionID
  attr_accessor :authorizationID
  attr_accessor :transactionPrice
  attr_accessor :vATPercent

  def initialize(amountPaid = nil, buyer = nil, shippingDetails = nil, convertedAmountPaid = nil, convertedTransactionPrice = nil, createdDate = nil, depositType = nil, item = nil, quantityPurchased = nil, shippingHandlingTotal = nil, status = nil, transactionID = nil, authorizationID = nil, transactionPrice = nil, vATPercent = nil)
    @amountPaid = amountPaid
    @buyer = buyer
    @shippingDetails = shippingDetails
    @convertedAmountPaid = convertedAmountPaid
    @convertedTransactionPrice = convertedTransactionPrice
    @createdDate = createdDate
    @depositType = depositType
    @item = item
    @quantityPurchased = quantityPurchased
    @shippingHandlingTotal = shippingHandlingTotal
    @status = status
    @transactionID = transactionID
    @authorizationID = authorizationID
    @transactionPrice = transactionPrice
    @vATPercent = vATPercent
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentMeansType
class PaymentMeansType
  @@schema_type = "PaymentMeansType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["typeCodeID", ["SellerPaymentMethodCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TypeCodeID")]]
  ]

  attr_accessor :typeCodeID

  def initialize(typeCodeID = nil)
    @typeCodeID = typeCodeID
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentType
class PaymentType
  @@schema_type = "PaymentType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["paymentMeans", ["PaymentMeansType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentMeans")]]
  ]

  attr_accessor :paymentMeans

  def initialize(paymentMeans = nil)
    @paymentMeans = paymentMeans
  end
end

# {urn:ebay:apis:eBLBaseComponents}TransactionStatusType
class TransactionStatusType
  @@schema_type = "TransactionStatusType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["eBayPaymentStatus", "SOAP::SOAPInt"],
    ["incompleteState", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "IncompleteState")]],
    ["lastTimeModified", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastTimeModified")]],
    ["paymentMethodUsed", ["BuyerPaymentMethodCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentMethodUsed")]],
    ["statusIs", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StatusIs")]]
  ]

  attr_accessor :eBayPaymentStatus
  attr_accessor :incompleteState
  attr_accessor :lastTimeModified
  attr_accessor :paymentMethodUsed
  attr_accessor :statusIs

  def initialize(eBayPaymentStatus = nil, incompleteState = nil, lastTimeModified = nil, paymentMethodUsed = nil, statusIs = nil)
    @eBayPaymentStatus = eBayPaymentStatus
    @incompleteState = incompleteState
    @lastTimeModified = lastTimeModified
    @paymentMethodUsed = paymentMethodUsed
    @statusIs = statusIs
  end
end

# {urn:ebay:apis:eBLBaseComponents}UserType
class UserType
  @@schema_type = "UserType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["aboutMePage", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AboutMePage")]],
    ["eAISToken", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EAISToken")]],
    ["email", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Email")]],
    ["feedbackScore", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FeedbackScore")]],
    ["feedbackPrivate", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FeedbackPrivate")]],
    ["feedbackRatingStar", ["FeedbackRatingStarCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FeedbackRatingStar")]],
    ["iDVerified", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "IDVerified")]],
    ["newUser", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "NewUser")]],
    ["registrationAddress", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RegistrationAddress")]],
    ["registrationDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RegistrationDate")]],
    ["site", ["SiteCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Site")]],
    ["status", ["UserStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Status")]],
    ["userID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "UserID")]],
    ["userIDChanged", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "UserIDChanged")]],
    ["userIDLastChanged", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "UserIDLastChanged")]],
    ["vATStatus", ["VATStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "VATStatus")]],
    ["buyerInfo", ["BuyerType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyerInfo")]],
    ["sellerInfo", ["SellerType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SellerInfo")]]
  ]

  attr_accessor :aboutMePage
  attr_accessor :eAISToken
  attr_accessor :email
  attr_accessor :feedbackScore
  attr_accessor :feedbackPrivate
  attr_accessor :feedbackRatingStar
  attr_accessor :iDVerified
  attr_accessor :newUser
  attr_accessor :registrationAddress
  attr_accessor :registrationDate
  attr_accessor :site
  attr_accessor :status
  attr_accessor :userID
  attr_accessor :userIDChanged
  attr_accessor :userIDLastChanged
  attr_accessor :vATStatus
  attr_accessor :buyerInfo
  attr_accessor :sellerInfo

  def initialize(aboutMePage = nil, eAISToken = nil, email = nil, feedbackScore = nil, feedbackPrivate = nil, feedbackRatingStar = nil, iDVerified = nil, newUser = nil, registrationAddress = nil, registrationDate = nil, site = nil, status = nil, userID = nil, userIDChanged = nil, userIDLastChanged = nil, vATStatus = nil, buyerInfo = nil, sellerInfo = nil)
    @aboutMePage = aboutMePage
    @eAISToken = eAISToken
    @email = email
    @feedbackScore = feedbackScore
    @feedbackPrivate = feedbackPrivate
    @feedbackRatingStar = feedbackRatingStar
    @iDVerified = iDVerified
    @newUser = newUser
    @registrationAddress = registrationAddress
    @registrationDate = registrationDate
    @site = site
    @status = status
    @userID = userID
    @userIDChanged = userIDChanged
    @userIDLastChanged = userIDLastChanged
    @vATStatus = vATStatus
    @buyerInfo = buyerInfo
    @sellerInfo = sellerInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}VATDetailsType
class VATDetailsType
  @@schema_type = "VATDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["businessSeller", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BusinessSeller")]],
    ["restrictedToBusiness", ["SOAP::SOAPBoolean", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RestrictedToBusiness")]],
    ["vATPercent", ["SOAP::SOAPFloat", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "VATPercent")]]
  ]

  attr_accessor :businessSeller
  attr_accessor :restrictedToBusiness
  attr_accessor :vATPercent

  def initialize(businessSeller = nil, restrictedToBusiness = nil, vATPercent = nil)
    @businessSeller = businessSeller
    @restrictedToBusiness = restrictedToBusiness
    @vATPercent = vATPercent
  end
end

# {urn:ebay:apis:eBLBaseComponents}SchedulingInfoType
class SchedulingInfoType
  @@schema_type = "SchedulingInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["maxScheduledMinutes", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MaxScheduledMinutes")]],
    ["minScheduledMinutes", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MinScheduledMinutes")]],
    ["maxScheduledItems", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MaxScheduledItems")]]
  ]

  attr_accessor :maxScheduledMinutes
  attr_accessor :minScheduledMinutes
  attr_accessor :maxScheduledItems

  def initialize(maxScheduledMinutes = nil, minScheduledMinutes = nil, maxScheduledItems = nil)
    @maxScheduledMinutes = maxScheduledMinutes
    @minScheduledMinutes = minScheduledMinutes
    @maxScheduledItems = maxScheduledItems
  end
end

# {urn:ebay:apis:eBLBaseComponents}ItemArrayType
class ItemArrayType < ::Array
  @@schema_element = [
    ["Item", ["ItemType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Item")]]
  ]
end

# {urn:ebay:apis:eBLBaseComponents}CategoryArrayType
class CategoryArrayType < ::Array
  @@schema_element = [
    ["Category", ["CategoryType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Category")]]
  ]
end

# {urn:ebay:apis:eBLBaseComponents}PaginationType
class PaginationType
  @@schema_type = "PaginationType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["entriesPerPage", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EntriesPerPage")]],
    ["pageNumber", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PageNumber")]]
  ]

  attr_accessor :entriesPerPage
  attr_accessor :pageNumber

  def initialize(entriesPerPage = nil, pageNumber = nil)
    @entriesPerPage = entriesPerPage
    @pageNumber = pageNumber
  end
end

# {urn:ebay:apis:eBLBaseComponents}ModifiedFieldType
class ModifiedFieldType
  @@schema_type = "ModifiedFieldType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["field", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Field")]],
    ["modifyType", ["ModifyCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ModifyType")]]
  ]

  attr_accessor :field
  attr_accessor :modifyType

  def initialize(field = nil, modifyType = nil)
    @field = field
    @modifyType = modifyType
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaginationResultType
class PaginationResultType
  @@schema_type = "PaginationResultType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["totalNumberOfPages", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TotalNumberOfPages")]],
    ["totalNumberOfEntries", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TotalNumberOfEntries")]]
  ]

  attr_accessor :totalNumberOfPages
  attr_accessor :totalNumberOfEntries

  def initialize(totalNumberOfPages = nil, totalNumberOfEntries = nil)
    @totalNumberOfPages = totalNumberOfPages
    @totalNumberOfEntries = totalNumberOfEntries
  end
end

# {urn:ebay:apis:eBLBaseComponents}ErrorParameterType
class ErrorParameterType
  @@schema_type = "ErrorParameterType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "ParamID") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["value", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Value")]]
  ]

  attr_accessor :value

  def xmlattr_ParamID
    (@__xmlattr ||= {})[XSD::QName.new(nil, "ParamID")]
  end

  def xmlattr_ParamID=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "ParamID")] = value
  end

  def initialize(value = nil)
    @value = value
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}ErrorType
class ErrorType
  @@schema_type = "ErrorType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["shortMessage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShortMessage")]],
    ["longMessage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LongMessage")]],
    ["errorCode", ["Token", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorCode")]],
    ["severityCode", ["SeverityCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SeverityCode")]],
    ["errorParameters", ["ErrorParameterType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorParameters")]]
  ]

  attr_accessor :shortMessage
  attr_accessor :longMessage
  attr_accessor :errorCode
  attr_accessor :severityCode
  attr_accessor :errorParameters

  def initialize(shortMessage = nil, longMessage = nil, errorCode = nil, severityCode = nil, errorParameters = [])
    @shortMessage = shortMessage
    @longMessage = longMessage
    @errorCode = errorCode
    @severityCode = severityCode
    @errorParameters = errorParameters
  end
end

# {urn:ebay:apis:eBLBaseComponents}FaultDetailsType
class FaultDetailsType
  @@schema_type = "FaultDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["errorCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorCode")]],
    ["severity", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Severity")]],
    ["detailedMessage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailedMessage")]]
  ]

  attr_accessor :errorCode
  attr_accessor :severity
  attr_accessor :detailedMessage

  def initialize(errorCode = nil, severity = nil, detailedMessage = nil)
    @errorCode = errorCode
    @severity = severity
    @detailedMessage = detailedMessage
  end
end

# {urn:ebay:apis:eBLBaseComponents}AbstractRequestType
class AbstractRequestType
  @@schema_type = "AbstractRequestType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["detailLevel", ["DetailLevelCodeType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DetailLevel")]],
    ["errorLanguage", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ErrorLanguage")]],
    ["messageID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MessageID")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]]
  ]

  attr_accessor :detailLevel
  attr_accessor :errorLanguage
  attr_accessor :messageID
  attr_accessor :version
  attr_reader :__xmlele_any

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(detailLevel = [], errorLanguage = nil, messageID = nil, version = nil)
    @detailLevel = detailLevel
    @errorLanguage = errorLanguage
    @messageID = messageID
    @version = version
    @__xmlele_any = nil
  end
end

# {urn:ebay:apis:eBLBaseComponents}AbstractResponseType
class AbstractResponseType
  @@schema_type = "AbstractResponseType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["ack", ["AckCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Ack")]],
    ["correlationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CorrelationID")]],
    ["errors", ["ErrorType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Errors")]],
    ["version", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Version")]],
    ["build", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Build")]],
    ["any", [nil, XSD::QName.new("http://www.w3.org/2001/XMLSchema", "anyType")]]
  ]

  attr_accessor :timestamp
  attr_accessor :ack
  attr_accessor :correlationID
  attr_accessor :errors
  attr_accessor :version
  attr_accessor :build
  attr_reader :__xmlele_any

  def set_any(elements)
    @__xmlele_any = elements
  end

  def initialize(timestamp = nil, ack = nil, correlationID = nil, errors = [], version = nil, build = nil)
    @timestamp = timestamp
    @ack = ack
    @correlationID = correlationID
    @errors = errors
    @version = version
    @build = build
    @__xmlele_any = nil
  end
end

# {urn:ebay:apis:eBLBaseComponents}AddressType
class AddressType
  @@schema_type = "AddressType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["street1", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Street1")]],
    ["street2", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Street2")]],
    ["cityName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CityName")]],
    ["stateOrProvince", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StateOrProvince")]],
    ["country", ["CountryCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Country")]],
    ["countryName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CountryName")]],
    ["phone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Phone")]],
    ["postalCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PostalCode")]],
    ["addressID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AddressID")]],
    ["addressOwner", ["AddressOwnerCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AddressOwner")]],
    ["externalAddressID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ExternalAddressID")]],
    ["internationalName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InternationalName")]],
    ["internationalStateAndCity", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InternationalStateAndCity")]],
    ["internationalStreet", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InternationalStreet")]],
    ["addressStatus", ["AddressStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AddressStatus")]]
  ]

  attr_accessor :name
  attr_accessor :street1
  attr_accessor :street2
  attr_accessor :cityName
  attr_accessor :stateOrProvince
  attr_accessor :country
  attr_accessor :countryName
  attr_accessor :phone
  attr_accessor :postalCode
  attr_accessor :addressID
  attr_accessor :addressOwner
  attr_accessor :externalAddressID
  attr_accessor :internationalName
  attr_accessor :internationalStateAndCity
  attr_accessor :internationalStreet
  attr_accessor :addressStatus

  def initialize(name = nil, street1 = nil, street2 = nil, cityName = nil, stateOrProvince = nil, country = nil, countryName = nil, phone = nil, postalCode = nil, addressID = nil, addressOwner = nil, externalAddressID = nil, internationalName = nil, internationalStateAndCity = nil, internationalStreet = nil, addressStatus = nil)
    @name = name
    @street1 = street1
    @street2 = street2
    @cityName = cityName
    @stateOrProvince = stateOrProvince
    @country = country
    @countryName = countryName
    @phone = phone
    @postalCode = postalCode
    @addressID = addressID
    @addressOwner = addressOwner
    @externalAddressID = externalAddressID
    @internationalName = internationalName
    @internationalStateAndCity = internationalStateAndCity
    @internationalStreet = internationalStreet
    @addressStatus = addressStatus
  end
end

# {urn:ebay:apis:eBLBaseComponents}PersonNameType
class PersonNameType
  @@schema_type = "PersonNameType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["salutation", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Salutation")]],
    ["firstName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FirstName")]],
    ["middleName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MiddleName")]],
    ["lastName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastName")]],
    ["suffix", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Suffix")]]
  ]

  attr_accessor :salutation
  attr_accessor :firstName
  attr_accessor :middleName
  attr_accessor :lastName
  attr_accessor :suffix

  def initialize(salutation = nil, firstName = nil, middleName = nil, lastName = nil, suffix = nil)
    @salutation = salutation
    @firstName = firstName
    @middleName = middleName
    @lastName = lastName
    @suffix = suffix
  end
end

# {urn:ebay:apis:eBLBaseComponents}SetExpressCheckoutRequestDetailsType
class SetExpressCheckoutRequestDetailsType
  @@schema_type = "SetExpressCheckoutRequestDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["orderTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OrderTotal")]],
    ["returnURL", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReturnURL")]],
    ["cancelURL", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CancelURL")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Token")]],
    ["maxAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MaxAmount")]],
    ["orderDescription", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OrderDescription")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InvoiceID")]],
    ["reqConfirmShipping", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReqConfirmShipping")]],
    ["noShipping", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "NoShipping")]],
    ["addressOverride", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AddressOverride")]],
    ["localeCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LocaleCode")]],
    ["pageStyle", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PageStyle")]],
    ["cpp_header_image", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "cpp-header-image")]],
    ["cpp_header_border_color", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "cpp-header-border-color")]],
    ["cpp_header_back_color", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "cpp-header-back-color")]],
    ["cpp_payflow_color", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "cpp-payflow-color")]],
    ["address", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Address")]],
    ["paymentAction", ["PaymentActionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentAction")]],
    ["buyerEmail", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyerEmail")]]
  ]

  attr_accessor :orderTotal
  attr_accessor :returnURL
  attr_accessor :cancelURL
  attr_accessor :token
  attr_accessor :maxAmount
  attr_accessor :orderDescription
  attr_accessor :custom
  attr_accessor :invoiceID
  attr_accessor :reqConfirmShipping
  attr_accessor :noShipping
  attr_accessor :addressOverride
  attr_accessor :localeCode
  attr_accessor :pageStyle
  attr_accessor :cpp_header_image
  attr_accessor :cpp_header_border_color
  attr_accessor :cpp_header_back_color
  attr_accessor :cpp_payflow_color
  attr_accessor :address
  attr_accessor :paymentAction
  attr_accessor :buyerEmail

  def initialize(orderTotal = nil, returnURL = nil, cancelURL = nil, token = nil, maxAmount = nil, orderDescription = nil, custom = nil, invoiceID = nil, reqConfirmShipping = nil, noShipping = nil, addressOverride = nil, localeCode = nil, pageStyle = nil, cpp_header_image = nil, cpp_header_border_color = nil, cpp_header_back_color = nil, cpp_payflow_color = nil, address = nil, paymentAction = nil, buyerEmail = nil)
    @orderTotal = orderTotal
    @returnURL = returnURL
    @cancelURL = cancelURL
    @token = token
    @maxAmount = maxAmount
    @orderDescription = orderDescription
    @custom = custom
    @invoiceID = invoiceID
    @reqConfirmShipping = reqConfirmShipping
    @noShipping = noShipping
    @addressOverride = addressOverride
    @localeCode = localeCode
    @pageStyle = pageStyle
    @cpp_header_image = cpp_header_image
    @cpp_header_border_color = cpp_header_border_color
    @cpp_header_back_color = cpp_header_back_color
    @cpp_payflow_color = cpp_payflow_color
    @address = address
    @paymentAction = paymentAction
    @buyerEmail = buyerEmail
  end
end

# {urn:ebay:apis:eBLBaseComponents}GetExpressCheckoutDetailsResponseDetailsType
class GetExpressCheckoutDetailsResponseDetailsType
  @@schema_type = "GetExpressCheckoutDetailsResponseDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Token")]],
    ["payerInfo", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerInfo")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InvoiceID")]],
    ["contactPhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ContactPhone")]]
  ]

  attr_accessor :token
  attr_accessor :payerInfo
  attr_accessor :custom
  attr_accessor :invoiceID
  attr_accessor :contactPhone

  def initialize(token = nil, payerInfo = nil, custom = nil, invoiceID = nil, contactPhone = nil)
    @token = token
    @payerInfo = payerInfo
    @custom = custom
    @invoiceID = invoiceID
    @contactPhone = contactPhone
  end
end

# {urn:ebay:apis:eBLBaseComponents}DoExpressCheckoutPaymentRequestDetailsType
class DoExpressCheckoutPaymentRequestDetailsType
  @@schema_type = "DoExpressCheckoutPaymentRequestDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["paymentAction", ["PaymentActionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentAction")]],
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Token")]],
    ["payerID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerID")]],
    ["paymentDetails", ["PaymentDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentDetails")]]
  ]

  attr_accessor :paymentAction
  attr_accessor :token
  attr_accessor :payerID
  attr_accessor :paymentDetails

  def initialize(paymentAction = nil, token = nil, payerID = nil, paymentDetails = nil)
    @paymentAction = paymentAction
    @token = token
    @payerID = payerID
    @paymentDetails = paymentDetails
  end
end

# {urn:ebay:apis:eBLBaseComponents}DoExpressCheckoutPaymentResponseDetailsType
class DoExpressCheckoutPaymentResponseDetailsType
  @@schema_type = "DoExpressCheckoutPaymentResponseDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["token", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Token")]],
    ["paymentInfo", ["PaymentInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentInfo")]]
  ]

  attr_accessor :token
  attr_accessor :paymentInfo

  def initialize(token = nil, paymentInfo = nil)
    @token = token
    @paymentInfo = paymentInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}DoCaptureResponseDetailsType
class DoCaptureResponseDetailsType
  @@schema_type = "DoCaptureResponseDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["authorizationID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AuthorizationID")]],
    ["paymentInfo", ["PaymentInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentInfo")]]
  ]

  attr_accessor :authorizationID
  attr_accessor :paymentInfo

  def initialize(authorizationID = nil, paymentInfo = nil)
    @authorizationID = authorizationID
    @paymentInfo = paymentInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}DoDirectPaymentRequestDetailsType
class DoDirectPaymentRequestDetailsType
  @@schema_type = "DoDirectPaymentRequestDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["paymentAction", ["PaymentActionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentAction")]],
    ["paymentDetails", ["PaymentDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentDetails")]],
    ["creditCard", ["CreditCardDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CreditCard")]],
    ["iPAddress", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "IPAddress")]],
    ["merchantSessionId", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MerchantSessionId")]]
  ]

  attr_accessor :paymentAction
  attr_accessor :paymentDetails
  attr_accessor :creditCard
  attr_accessor :iPAddress
  attr_accessor :merchantSessionId

  def initialize(paymentAction = nil, paymentDetails = nil, creditCard = nil, iPAddress = nil, merchantSessionId = nil)
    @paymentAction = paymentAction
    @paymentDetails = paymentDetails
    @creditCard = creditCard
    @iPAddress = iPAddress
    @merchantSessionId = merchantSessionId
  end
end

# {urn:ebay:apis:eBLBaseComponents}BAUpdateResponseDetailsType
class BAUpdateResponseDetailsType
  @@schema_type = "BAUpdateResponseDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["mpID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MpID")]],
    ["payerInfo", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerInfo")]],
    ["merchantPullInfo", ["MerchantPullInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MerchantPullInfo")]]
  ]

  attr_accessor :mpID
  attr_accessor :payerInfo
  attr_accessor :merchantPullInfo

  def initialize(mpID = nil, payerInfo = nil, merchantPullInfo = nil)
    @mpID = mpID
    @payerInfo = payerInfo
    @merchantPullInfo = merchantPullInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}MerchantPullPaymentResponseType
class MerchantPullPaymentResponseType
  @@schema_type = "MerchantPullPaymentResponseType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["payerInfo", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerInfo")]],
    ["paymentInfo", ["PaymentInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentInfo")]],
    ["merchantPullInfo", ["MerchantPullInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MerchantPullInfo")]]
  ]

  attr_accessor :payerInfo
  attr_accessor :paymentInfo
  attr_accessor :merchantPullInfo

  def initialize(payerInfo = nil, paymentInfo = nil, merchantPullInfo = nil)
    @payerInfo = payerInfo
    @paymentInfo = paymentInfo
    @merchantPullInfo = merchantPullInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}MerchantPullInfoType
class MerchantPullInfoType
  @@schema_type = "MerchantPullInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["mpStatus", ["MerchantPullStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MpStatus")]],
    ["mpMax", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MpMax")]],
    ["mpCustom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MpCustom")]],
    ["desc", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Desc")]],
    ["invoice", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Invoice")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["paymentSourceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentSourceID")]]
  ]

  attr_accessor :mpStatus
  attr_accessor :mpMax
  attr_accessor :mpCustom
  attr_accessor :desc
  attr_accessor :invoice
  attr_accessor :custom
  attr_accessor :paymentSourceID

  def initialize(mpStatus = nil, mpMax = nil, mpCustom = nil, desc = nil, invoice = nil, custom = nil, paymentSourceID = nil)
    @mpStatus = mpStatus
    @mpMax = mpMax
    @mpCustom = mpCustom
    @desc = desc
    @invoice = invoice
    @custom = custom
    @paymentSourceID = paymentSourceID
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentTransactionSearchResultType
class PaymentTransactionSearchResultType
  @@schema_type = "PaymentTransactionSearchResultType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["timestamp", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timestamp")]],
    ["timezone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Timezone")]],
    ["type", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Type")]],
    ["payer", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Payer")]],
    ["payerDisplayName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerDisplayName")]],
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TransactionID")]],
    ["status", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Status")]],
    ["grossAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GrossAmount")]],
    ["feeAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FeeAmount")]],
    ["netAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "NetAmount")]]
  ]

  attr_accessor :timestamp
  attr_accessor :timezone
  attr_accessor :type
  attr_accessor :payer
  attr_accessor :payerDisplayName
  attr_accessor :transactionID
  attr_accessor :status
  attr_accessor :grossAmount
  attr_accessor :feeAmount
  attr_accessor :netAmount

  def initialize(timestamp = nil, timezone = nil, type = nil, payer = nil, payerDisplayName = nil, transactionID = nil, status = nil, grossAmount = nil, feeAmount = nil, netAmount = nil)
    @timestamp = timestamp
    @timezone = timezone
    @type = type
    @payer = payer
    @payerDisplayName = payerDisplayName
    @transactionID = transactionID
    @status = status
    @grossAmount = grossAmount
    @feeAmount = feeAmount
    @netAmount = netAmount
  end
end

# {urn:ebay:apis:eBLBaseComponents}MerchantPullPaymentType
class MerchantPullPaymentType
  @@schema_type = "MerchantPullPaymentType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Amount")]],
    ["mpID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MpID")]],
    ["paymentType", ["MerchantPullPaymentCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentType")]],
    ["memo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Memo")]],
    ["emailSubject", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EmailSubject")]],
    ["tax", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Tax")]],
    ["shipping", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Shipping")]],
    ["handling", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Handling")]],
    ["itemName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemName")]],
    ["itemNumber", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemNumber")]],
    ["invoice", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Invoice")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["buttonSource", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ButtonSource")]]
  ]

  attr_accessor :amount
  attr_accessor :mpID
  attr_accessor :paymentType
  attr_accessor :memo
  attr_accessor :emailSubject
  attr_accessor :tax
  attr_accessor :shipping
  attr_accessor :handling
  attr_accessor :itemName
  attr_accessor :itemNumber
  attr_accessor :invoice
  attr_accessor :custom
  attr_accessor :buttonSource

  def initialize(amount = nil, mpID = nil, paymentType = nil, memo = nil, emailSubject = nil, tax = nil, shipping = nil, handling = nil, itemName = nil, itemNumber = nil, invoice = nil, custom = nil, buttonSource = nil)
    @amount = amount
    @mpID = mpID
    @paymentType = paymentType
    @memo = memo
    @emailSubject = emailSubject
    @tax = tax
    @shipping = shipping
    @handling = handling
    @itemName = itemName
    @itemNumber = itemNumber
    @invoice = invoice
    @custom = custom
    @buttonSource = buttonSource
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentTransactionType
class PaymentTransactionType
  @@schema_type = "PaymentTransactionType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["receiverInfo", ["ReceiverInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReceiverInfo")]],
    ["payerInfo", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerInfo")]],
    ["paymentInfo", ["PaymentInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentInfo")]],
    ["paymentItemInfo", ["PaymentItemInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentItemInfo")]]
  ]

  attr_accessor :receiverInfo
  attr_accessor :payerInfo
  attr_accessor :paymentInfo
  attr_accessor :paymentItemInfo

  def initialize(receiverInfo = nil, payerInfo = nil, paymentInfo = nil, paymentItemInfo = nil)
    @receiverInfo = receiverInfo
    @payerInfo = payerInfo
    @paymentInfo = paymentInfo
    @paymentItemInfo = paymentItemInfo
  end
end

# {urn:ebay:apis:eBLBaseComponents}ReceiverInfoType
class ReceiverInfoType
  @@schema_type = "ReceiverInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["business", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Business")]],
    ["receiver", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Receiver")]],
    ["receiverID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReceiverID")]]
  ]

  attr_accessor :business
  attr_accessor :receiver
  attr_accessor :receiverID

  def initialize(business = nil, receiver = nil, receiverID = nil)
    @business = business
    @receiver = receiver
    @receiverID = receiverID
  end
end

# {urn:ebay:apis:eBLBaseComponents}PayerInfoType
class PayerInfoType
  @@schema_type = "PayerInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["payer", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Payer")]],
    ["payerID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerID")]],
    ["payerStatus", ["PayPalUserStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerStatus")]],
    ["payerName", ["PersonNameType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerName")]],
    ["payerCountry", ["CountryCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerCountry")]],
    ["payerBusiness", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PayerBusiness")]],
    ["address", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Address")]],
    ["contactPhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ContactPhone")]]
  ]

  attr_accessor :payer
  attr_accessor :payerID
  attr_accessor :payerStatus
  attr_accessor :payerName
  attr_accessor :payerCountry
  attr_accessor :payerBusiness
  attr_accessor :address
  attr_accessor :contactPhone

  def initialize(payer = nil, payerID = nil, payerStatus = nil, payerName = nil, payerCountry = nil, payerBusiness = nil, address = nil, contactPhone = nil)
    @payer = payer
    @payerID = payerID
    @payerStatus = payerStatus
    @payerName = payerName
    @payerCountry = payerCountry
    @payerBusiness = payerBusiness
    @address = address
    @contactPhone = contactPhone
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentInfoType
class PaymentInfoType
  @@schema_type = "PaymentInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["transactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TransactionID")]],
    ["parentTransactionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ParentTransactionID")]],
    ["receiptID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReceiptID")]],
    ["transactionType", ["PaymentTransactionCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TransactionType")]],
    ["paymentType", ["PaymentCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentType")]],
    ["paymentDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentDate")]],
    ["grossAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "GrossAmount")]],
    ["feeAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "FeeAmount")]],
    ["settleAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SettleAmount")]],
    ["taxAmount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TaxAmount")]],
    ["exchangeRate", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ExchangeRate")]],
    ["paymentStatus", ["PaymentStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentStatus")]],
    ["pendingReason", ["PendingStatusCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PendingReason")]],
    ["reasonCode", ["ReversalReasonCodeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ReasonCode")]]
  ]

  attr_accessor :transactionID
  attr_accessor :parentTransactionID
  attr_accessor :receiptID
  attr_accessor :transactionType
  attr_accessor :paymentType
  attr_accessor :paymentDate
  attr_accessor :grossAmount
  attr_accessor :feeAmount
  attr_accessor :settleAmount
  attr_accessor :taxAmount
  attr_accessor :exchangeRate
  attr_accessor :paymentStatus
  attr_accessor :pendingReason
  attr_accessor :reasonCode

  def initialize(transactionID = nil, parentTransactionID = nil, receiptID = nil, transactionType = nil, paymentType = nil, paymentDate = nil, grossAmount = nil, feeAmount = nil, settleAmount = nil, taxAmount = nil, exchangeRate = nil, paymentStatus = nil, pendingReason = nil, reasonCode = nil)
    @transactionID = transactionID
    @parentTransactionID = parentTransactionID
    @receiptID = receiptID
    @transactionType = transactionType
    @paymentType = paymentType
    @paymentDate = paymentDate
    @grossAmount = grossAmount
    @feeAmount = feeAmount
    @settleAmount = settleAmount
    @taxAmount = taxAmount
    @exchangeRate = exchangeRate
    @paymentStatus = paymentStatus
    @pendingReason = pendingReason
    @reasonCode = reasonCode
  end
end

# {urn:ebay:apis:eBLBaseComponents}SubscriptionTermsType
class SubscriptionTermsType
  @@schema_type = "SubscriptionTermsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "period") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Amount")]]
  ]

  attr_accessor :amount

  def xmlattr_period
    (@__xmlattr ||= {})[XSD::QName.new(nil, "period")]
  end

  def xmlattr_period=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "period")] = value
  end

  def initialize(amount = nil)
    @amount = amount
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}SubscriptionInfoType
class SubscriptionInfoType
  @@schema_type = "SubscriptionInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "reattempt") => "SOAP::SOAPString",
    XSD::QName.new(nil, "recurring") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["subscriptionID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SubscriptionID")]],
    ["subscriptionDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SubscriptionDate")]],
    ["effectiveDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "EffectiveDate")]],
    ["retryTime", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RetryTime")]],
    ["username", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Username")]],
    ["password", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Password")]],
    ["recurrences", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Recurrences")]],
    ["terms", ["SubscriptionTermsType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Terms")]]
  ]

  attr_accessor :subscriptionID
  attr_accessor :subscriptionDate
  attr_accessor :effectiveDate
  attr_accessor :retryTime
  attr_accessor :username
  attr_accessor :password
  attr_accessor :recurrences
  attr_accessor :terms

  def xmlattr_reattempt
    (@__xmlattr ||= {})[XSD::QName.new(nil, "reattempt")]
  end

  def xmlattr_reattempt=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "reattempt")] = value
  end

  def xmlattr_recurring
    (@__xmlattr ||= {})[XSD::QName.new(nil, "recurring")]
  end

  def xmlattr_recurring=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "recurring")] = value
  end

  def initialize(subscriptionID = nil, subscriptionDate = nil, effectiveDate = nil, retryTime = nil, username = nil, password = nil, recurrences = nil, terms = [])
    @subscriptionID = subscriptionID
    @subscriptionDate = subscriptionDate
    @effectiveDate = effectiveDate
    @retryTime = retryTime
    @username = username
    @password = password
    @recurrences = recurrences
    @terms = terms
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}AuctionInfoType
class AuctionInfoType
  @@schema_type = "AuctionInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "multiItem") => "SOAP::SOAPString"
  }
  @@schema_element = [
    ["buyerID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BuyerID")]],
    ["closingDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ClosingDate")]]
  ]

  attr_accessor :buyerID
  attr_accessor :closingDate

  def xmlattr_multiItem
    (@__xmlattr ||= {})[XSD::QName.new(nil, "multiItem")]
  end

  def xmlattr_multiItem=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "multiItem")] = value
  end

  def initialize(buyerID = nil, closingDate = nil)
    @buyerID = buyerID
    @closingDate = closingDate
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}OptionType
class OptionType
  @@schema_type = "OptionType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_attribute = {
    XSD::QName.new(nil, "name") => "SOAP::SOAPString",
    XSD::QName.new(nil, "value") => "SOAP::SOAPString"
  }
  @@schema_element = []

  def xmlattr_name
    (@__xmlattr ||= {})[XSD::QName.new(nil, "name")]
  end

  def xmlattr_name=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "name")] = value
  end

  def xmlattr_value
    (@__xmlattr ||= {})[XSD::QName.new(nil, "value")]
  end

  def xmlattr_value=(value)
    (@__xmlattr ||= {})[XSD::QName.new(nil, "value")] = value
  end

  def initialize
    @__xmlattr = {}
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentDetailsItemType
class PaymentDetailsItemType
  @@schema_type = "PaymentDetailsItemType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["number", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Number")]],
    ["quantity", ["SOAP::SOAPInteger", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Quantity")]],
    ["tax", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Tax")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Amount")]]
  ]

  attr_accessor :name
  attr_accessor :number
  attr_accessor :quantity
  attr_accessor :tax
  attr_accessor :amount

  def initialize(name = nil, number = nil, quantity = nil, tax = nil, amount = nil)
    @name = name
    @number = number
    @quantity = quantity
    @tax = tax
    @amount = amount
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentItemType
class PaymentItemType
  @@schema_type = "PaymentItemType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["number", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Number")]],
    ["quantity", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Quantity")]],
    ["salesTax", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesTax")]],
    ["amount", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Amount")]],
    ["options", ["OptionType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Options")]]
  ]

  attr_accessor :name
  attr_accessor :number
  attr_accessor :quantity
  attr_accessor :salesTax
  attr_accessor :amount
  attr_accessor :options

  def initialize(name = nil, number = nil, quantity = nil, salesTax = nil, amount = nil, options = [])
    @name = name
    @number = number
    @quantity = quantity
    @salesTax = salesTax
    @amount = amount
    @options = options
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentItemInfoType
class PaymentItemInfoType
  @@schema_type = "PaymentItemInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InvoiceID")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["memo", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Memo")]],
    ["salesTax", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesTax")]],
    ["paymentItem", ["PaymentItemType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentItem")]],
    ["subscription", ["SubscriptionInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Subscription")]],
    ["auction", ["AuctionInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Auction")]]
  ]

  attr_accessor :invoiceID
  attr_accessor :custom
  attr_accessor :memo
  attr_accessor :salesTax
  attr_accessor :paymentItem
  attr_accessor :subscription
  attr_accessor :auction

  def initialize(invoiceID = nil, custom = nil, memo = nil, salesTax = nil, paymentItem = [], subscription = nil, auction = nil)
    @invoiceID = invoiceID
    @custom = custom
    @memo = memo
    @salesTax = salesTax
    @paymentItem = paymentItem
    @subscription = subscription
    @auction = auction
  end
end

# {urn:ebay:apis:eBLBaseComponents}PaymentDetailsType
class PaymentDetailsType
  @@schema_type = "PaymentDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["orderTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OrderTotal")]],
    ["itemTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ItemTotal")]],
    ["shippingTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShippingTotal")]],
    ["handlingTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HandlingTotal")]],
    ["taxTotal", ["BasicAmountType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "TaxTotal")]],
    ["orderDescription", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OrderDescription")]],
    ["custom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Custom")]],
    ["invoiceID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "InvoiceID")]],
    ["buttonSource", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ButtonSource")]],
    ["notifyURL", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "NotifyURL")]],
    ["shipToAddress", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ShipToAddress")]],
    ["paymentDetailsItem", ["PaymentDetailsItemType[]", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PaymentDetailsItem")]]
  ]

  attr_accessor :orderTotal
  attr_accessor :itemTotal
  attr_accessor :shippingTotal
  attr_accessor :handlingTotal
  attr_accessor :taxTotal
  attr_accessor :orderDescription
  attr_accessor :custom
  attr_accessor :invoiceID
  attr_accessor :buttonSource
  attr_accessor :notifyURL
  attr_accessor :shipToAddress
  attr_accessor :paymentDetailsItem

  def initialize(orderTotal = nil, itemTotal = nil, shippingTotal = nil, handlingTotal = nil, taxTotal = nil, orderDescription = nil, custom = nil, invoiceID = nil, buttonSource = nil, notifyURL = nil, shipToAddress = nil, paymentDetailsItem = [])
    @orderTotal = orderTotal
    @itemTotal = itemTotal
    @shippingTotal = shippingTotal
    @handlingTotal = handlingTotal
    @taxTotal = taxTotal
    @orderDescription = orderDescription
    @custom = custom
    @invoiceID = invoiceID
    @buttonSource = buttonSource
    @notifyURL = notifyURL
    @shipToAddress = shipToAddress
    @paymentDetailsItem = paymentDetailsItem
  end
end

# {urn:ebay:apis:eBLBaseComponents}CreditCardDetailsType
class CreditCardDetailsType
  @@schema_type = "CreditCardDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["creditCardType", ["CreditCardTypeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CreditCardType")]],
    ["creditCardNumber", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CreditCardNumber")]],
    ["expMonth", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ExpMonth")]],
    ["expYear", ["SOAP::SOAPInt", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ExpYear")]],
    ["cardOwner", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CardOwner")]],
    ["cVV2", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CVV2")]]
  ]

  attr_accessor :creditCardType
  attr_accessor :creditCardNumber
  attr_accessor :expMonth
  attr_accessor :expYear
  attr_accessor :cardOwner
  attr_accessor :cVV2

  def initialize(creditCardType = nil, creditCardNumber = nil, expMonth = nil, expYear = nil, cardOwner = nil, cVV2 = nil)
    @creditCardType = creditCardType
    @creditCardNumber = creditCardNumber
    @expMonth = expMonth
    @expYear = expYear
    @cardOwner = cardOwner
    @cVV2 = cVV2
  end
end

# {urn:ebay:apis:eBLBaseComponents}CustomSecurityHeaderType
class CustomSecurityHeaderType
  @@schema_type = "CustomSecurityHeaderType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["eBayAuthToken", "SOAP::SOAPString"],
    ["hardExpirationWarning", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HardExpirationWarning")]],
    ["credentials", ["UserIdPasswordType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Credentials")]]
  ]

  attr_accessor :eBayAuthToken
  attr_accessor :hardExpirationWarning
  attr_accessor :credentials

  def initialize(eBayAuthToken = nil, hardExpirationWarning = nil, credentials = nil)
    @eBayAuthToken = eBayAuthToken
    @hardExpirationWarning = hardExpirationWarning
    @credentials = credentials
  end
end

# {urn:ebay:apis:eBLBaseComponents}UserIdPasswordType
class UserIdPasswordType
  @@schema_type = "UserIdPasswordType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["appId", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AppId")]],
    ["devId", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "DevId")]],
    ["authCert", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AuthCert")]],
    ["username", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Username")]],
    ["password", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Password")]],
    ["signature", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Signature")]],
    ["subject", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Subject")]]
  ]

  attr_accessor :appId
  attr_accessor :devId
  attr_accessor :authCert
  attr_accessor :username
  attr_accessor :password
  attr_accessor :signature
  attr_accessor :subject

  def initialize(appId = nil, devId = nil, authCert = nil, username = nil, password = nil, signature = nil, subject = nil)
    @appId = appId
    @devId = devId
    @authCert = authCert
    @username = username
    @password = password
    @signature = signature
    @subject = subject
  end
end

# {urn:ebay:apis:eBLBaseComponents}EnterBoardingRequestDetailsType
class EnterBoardingRequestDetailsType
  @@schema_type = "EnterBoardingRequestDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["programCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ProgramCode")]],
    ["productList", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ProductList")]],
    ["partnerCustom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PartnerCustom")]],
    ["imageUrl", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ImageUrl")]],
    ["marketingCategory", ["MarketingCategoryType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MarketingCategory")]],
    ["businessInfo", ["BusinessInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BusinessInfo")]],
    ["ownerInfo", ["BusinessOwnerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "OwnerInfo")]],
    ["bankAccount", ["BankAccountDetailsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BankAccount")]]
  ]

  attr_accessor :programCode
  attr_accessor :productList
  attr_accessor :partnerCustom
  attr_accessor :imageUrl
  attr_accessor :marketingCategory
  attr_accessor :businessInfo
  attr_accessor :ownerInfo
  attr_accessor :bankAccount

  def initialize(programCode = nil, productList = nil, partnerCustom = nil, imageUrl = nil, marketingCategory = nil, businessInfo = nil, ownerInfo = nil, bankAccount = nil)
    @programCode = programCode
    @productList = productList
    @partnerCustom = partnerCustom
    @imageUrl = imageUrl
    @marketingCategory = marketingCategory
    @businessInfo = businessInfo
    @ownerInfo = ownerInfo
    @bankAccount = bankAccount
  end
end

# {urn:ebay:apis:eBLBaseComponents}BusinessInfoType
class BusinessInfoType
  @@schema_type = "BusinessInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["type", ["BusinessTypeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Type")]],
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["address", ["AddressType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Address")]],
    ["workPhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "WorkPhone")]],
    ["category", ["BusinessCategoryType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Category")]],
    ["subCategory", ["BusinessSubCategoryType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SubCategory")]],
    ["averagePrice", ["AverageTransactionPriceType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AveragePrice")]],
    ["averageMonthlyVolume", ["AverageMonthlyVolumeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AverageMonthlyVolume")]],
    ["salesVenue", ["SalesVenueType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SalesVenue")]],
    ["website", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Website")]],
    ["revenueFromOnlineSales", ["PercentageRevenueFromOnlineSalesType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RevenueFromOnlineSales")]],
    ["businessEstablished", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "BusinessEstablished")]],
    ["customerServiceEmail", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CustomerServiceEmail")]],
    ["customerServicePhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CustomerServicePhone")]]
  ]

  attr_accessor :type
  attr_accessor :name
  attr_accessor :address
  attr_accessor :workPhone
  attr_accessor :category
  attr_accessor :subCategory
  attr_accessor :averagePrice
  attr_accessor :averageMonthlyVolume
  attr_accessor :salesVenue
  attr_accessor :website
  attr_accessor :revenueFromOnlineSales
  attr_accessor :businessEstablished
  attr_accessor :customerServiceEmail
  attr_accessor :customerServicePhone

  def initialize(type = nil, name = nil, address = nil, workPhone = nil, category = nil, subCategory = nil, averagePrice = nil, averageMonthlyVolume = nil, salesVenue = nil, website = nil, revenueFromOnlineSales = nil, businessEstablished = nil, customerServiceEmail = nil, customerServicePhone = nil)
    @type = type
    @name = name
    @address = address
    @workPhone = workPhone
    @category = category
    @subCategory = subCategory
    @averagePrice = averagePrice
    @averageMonthlyVolume = averageMonthlyVolume
    @salesVenue = salesVenue
    @website = website
    @revenueFromOnlineSales = revenueFromOnlineSales
    @businessEstablished = businessEstablished
    @customerServiceEmail = customerServiceEmail
    @customerServicePhone = customerServicePhone
  end
end

# {urn:ebay:apis:eBLBaseComponents}BusinessOwnerInfoType
class BusinessOwnerInfoType
  @@schema_type = "BusinessOwnerInfoType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["owner", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Owner")]],
    ["homePhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "HomePhone")]],
    ["mobilePhone", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "MobilePhone")]],
    ["sSN", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "SSN")]]
  ]

  attr_accessor :owner
  attr_accessor :homePhone
  attr_accessor :mobilePhone
  attr_accessor :sSN

  def initialize(owner = nil, homePhone = nil, mobilePhone = nil, sSN = nil)
    @owner = owner
    @homePhone = homePhone
    @mobilePhone = mobilePhone
    @sSN = sSN
  end
end

# {urn:ebay:apis:eBLBaseComponents}BankAccountDetailsType
class BankAccountDetailsType
  @@schema_type = "BankAccountDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["name", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Name")]],
    ["type", ["BankAccountTypeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Type")]],
    ["routingNumber", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "RoutingNumber")]],
    ["accountNumber", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AccountNumber")]]
  ]

  attr_accessor :name
  attr_accessor :type
  attr_accessor :routingNumber
  attr_accessor :accountNumber

  def initialize(name = nil, type = nil, routingNumber = nil, accountNumber = nil)
    @name = name
    @type = type
    @routingNumber = routingNumber
    @accountNumber = accountNumber
  end
end

# {urn:ebay:apis:eBLBaseComponents}GetBoardingDetailsResponseDetailsType
class GetBoardingDetailsResponseDetailsType
  @@schema_type = "GetBoardingDetailsResponseDetailsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["status", ["BoardingStatusType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Status")]],
    ["startDate", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "StartDate")]],
    ["lastUpdated", ["SOAP::SOAPDateTime", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "LastUpdated")]],
    ["reason", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Reason")]],
    ["programName", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ProgramName")]],
    ["programCode", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ProgramCode")]],
    ["campaignID", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "CampaignID")]],
    ["userWithdrawalLimit", ["UserWithdrawalLimitTypeType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "UserWithdrawalLimit")]],
    ["partnerCustom", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "PartnerCustom")]],
    ["accountOwner", ["PayerInfoType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "AccountOwner")]],
    ["credentials", ["APICredentialsType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Credentials")]],
    ["configureAPIs", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "ConfigureAPIs")]]
  ]

  attr_accessor :status
  attr_accessor :startDate
  attr_accessor :lastUpdated
  attr_accessor :reason
  attr_accessor :programName
  attr_accessor :programCode
  attr_accessor :campaignID
  attr_accessor :userWithdrawalLimit
  attr_accessor :partnerCustom
  attr_accessor :accountOwner
  attr_accessor :credentials
  attr_accessor :configureAPIs

  def initialize(status = nil, startDate = nil, lastUpdated = nil, reason = nil, programName = nil, programCode = nil, campaignID = nil, userWithdrawalLimit = nil, partnerCustom = nil, accountOwner = nil, credentials = nil, configureAPIs = nil)
    @status = status
    @startDate = startDate
    @lastUpdated = lastUpdated
    @reason = reason
    @programName = programName
    @programCode = programCode
    @campaignID = campaignID
    @userWithdrawalLimit = userWithdrawalLimit
    @partnerCustom = partnerCustom
    @accountOwner = accountOwner
    @credentials = credentials
    @configureAPIs = configureAPIs
  end
end

# {urn:ebay:apis:eBLBaseComponents}APICredentialsType
class APICredentialsType
  @@schema_type = "APICredentialsType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"
  @@schema_element = [
    ["username", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Username")]],
    ["password", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Password")]],
    ["signature", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Signature")]],
    ["certificate", ["SOAP::SOAPString", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Certificate")]],
    ["type", ["APIAuthenticationType", XSD::QName.new("urn:ebay:apis:eBLBaseComponents", "Type")]]
  ]

  attr_accessor :username
  attr_accessor :password
  attr_accessor :signature
  attr_accessor :certificate
  attr_accessor :type

  def initialize(username = nil, password = nil, signature = nil, certificate = nil, type = nil)
    @username = username
    @password = password
    @signature = signature
    @certificate = certificate
    @type = type
  end
end

# {urn:ebay:apis:eBLBaseComponents}AccountStateCodeType
class AccountStateCodeType < ::String
  @@schema_type = "AccountStateCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Active = AccountStateCodeType.new("Active")
  CustomCode = AccountStateCodeType.new("CustomCode")
  Inactive = AccountStateCodeType.new("Inactive")
  Pending = AccountStateCodeType.new("Pending")
end

# {urn:ebay:apis:eBLBaseComponents}AckCodeType
class AckCodeType < ::String
  @@schema_type = "AckCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = AckCodeType.new("CustomCode")
  Failure = AckCodeType.new("Failure")
  FailureWithWarning = AckCodeType.new("FailureWithWarning")
  Success = AckCodeType.new("Success")
  SuccessWithWarning = AckCodeType.new("SuccessWithWarning")
  Warning = AckCodeType.new("Warning")
end

# {urn:ebay:apis:eBLBaseComponents}AddressOwnerCodeType
class AddressOwnerCodeType < ::String
  @@schema_type = "AddressOwnerCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = AddressOwnerCodeType.new("CustomCode")
  EBay = AddressOwnerCodeType.new("eBay")
  PayPal = AddressOwnerCodeType.new("PayPal")
end

# {urn:ebay:apis:eBLBaseComponents}AuctionTypeCodeType
class AuctionTypeCodeType < ::String
  @@schema_type = "AuctionTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AdType = AuctionTypeCodeType.new("Ad type")
  Chinese = AuctionTypeCodeType.new("Chinese")
  CustomCode = AuctionTypeCodeType.new("CustomCode")
  Dutch = AuctionTypeCodeType.new("Dutch")
  FixedPriceItem = AuctionTypeCodeType.new("Fixed Price Item")
  Live = AuctionTypeCodeType.new("Live")
  PersonalOffer = AuctionTypeCodeType.new("Personal Offer")
  StoresFixedPrice = AuctionTypeCodeType.new("Stores Fixed-price")
  Unknown = AuctionTypeCodeType.new("Unknown")
end

# {urn:ebay:apis:eBLBaseComponents}BalanceCodeType
class BalanceCodeType < ::String
  @@schema_type = "BalanceCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = BalanceCodeType.new("CustomCode")
  Other = BalanceCodeType.new("Other")
end

# {urn:ebay:apis:eBLBaseComponents}BuyerPaymentMethodCodeType
class BuyerPaymentMethodCodeType < ::String
  @@schema_type = "BuyerPaymentMethodCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AmEx = BuyerPaymentMethodCodeType.new("AmEx")
  CCAccepted = BuyerPaymentMethodCodeType.new("CCAccepted")
  COD = BuyerPaymentMethodCodeType.new("COD")
  CashOnPickup = BuyerPaymentMethodCodeType.new("CashOnPickup")
  CustomCode = BuyerPaymentMethodCodeType.new("CustomCode")
  Discover = BuyerPaymentMethodCodeType.new("Discover")
  MOCC = BuyerPaymentMethodCodeType.new("MOCC")
  MoneyXferAccepted = BuyerPaymentMethodCodeType.new("MoneyXferAccepted")
  MoneyXferAcceptedinCheckout = BuyerPaymentMethodCodeType.new("MoneyXferAcceptedinCheckout")
  None = BuyerPaymentMethodCodeType.new("None")
  Other = BuyerPaymentMethodCodeType.new("Other")
  OtherOnlinePayments = BuyerPaymentMethodCodeType.new("OtherOnlinePayments")
  PayPal = BuyerPaymentMethodCodeType.new("PayPal")
  PaymentSeeDescription = BuyerPaymentMethodCodeType.new("PaymentSeeDescription")
  PersonalCheck = BuyerPaymentMethodCodeType.new("PersonalCheck")
  VisaMC = BuyerPaymentMethodCodeType.new("VisaMC")
end

# {urn:ebay:apis:eBLBaseComponents}BuyerProtectionCodeType
class BuyerProtectionCodeType < ::String
  @@schema_type = "BuyerProtectionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = BuyerProtectionCodeType.new("CustomCode")
  ItemEligible = BuyerProtectionCodeType.new("ItemEligible")
  ItemIneligible = BuyerProtectionCodeType.new("ItemIneligible")
  ItemMarkedEligible = BuyerProtectionCodeType.new("ItemMarkedEligible")
  ItemMarkedIneligible = BuyerProtectionCodeType.new("ItemMarkedIneligible")
end

# {urn:ebay:apis:eBLBaseComponents}CheckoutStatusCodeType
class CheckoutStatusCodeType < ::String
  @@schema_type = "CheckoutStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  BuyerRequestsTotal = CheckoutStatusCodeType.new("BuyerRequestsTotal")
  CheckoutComplete = CheckoutStatusCodeType.new("CheckoutComplete")
  CheckoutIncomplete = CheckoutStatusCodeType.new("CheckoutIncomplete")
  CustomCode = CheckoutStatusCodeType.new("CustomCode")
  SellerResponded = CheckoutStatusCodeType.new("SellerResponded")
end

# {urn:ebay:apis:eBLBaseComponents}CountryCodeType
class CountryCodeType < ::String
  @@schema_type = "CountryCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AA = CountryCodeType.new("AA")
  AD = CountryCodeType.new("AD")
  AE = CountryCodeType.new("AE")
  AF = CountryCodeType.new("AF")
  AG = CountryCodeType.new("AG")
  AI = CountryCodeType.new("AI")
  AL = CountryCodeType.new("AL")
  AM = CountryCodeType.new("AM")
  AN = CountryCodeType.new("AN")
  AO = CountryCodeType.new("AO")
  AQ = CountryCodeType.new("AQ")
  AR = CountryCodeType.new("AR")
  AS = CountryCodeType.new("AS")
  AT = CountryCodeType.new("AT")
  AU = CountryCodeType.new("AU")
  AW = CountryCodeType.new("AW")
  AZ = CountryCodeType.new("AZ")
  BA = CountryCodeType.new("BA")
  BB = CountryCodeType.new("BB")
  BD = CountryCodeType.new("BD")
  BE = CountryCodeType.new("BE")
  BF = CountryCodeType.new("BF")
  BG = CountryCodeType.new("BG")
  BH = CountryCodeType.new("BH")
  BI = CountryCodeType.new("BI")
  BJ = CountryCodeType.new("BJ")
  BM = CountryCodeType.new("BM")
  BN = CountryCodeType.new("BN")
  BO = CountryCodeType.new("BO")
  BR = CountryCodeType.new("BR")
  BS = CountryCodeType.new("BS")
  BT = CountryCodeType.new("BT")
  BV = CountryCodeType.new("BV")
  BW = CountryCodeType.new("BW")
  BY = CountryCodeType.new("BY")
  BZ = CountryCodeType.new("BZ")
  CA = CountryCodeType.new("CA")
  CC = CountryCodeType.new("CC")
  CD = CountryCodeType.new("CD")
  CF = CountryCodeType.new("CF")
  CG = CountryCodeType.new("CG")
  CH = CountryCodeType.new("CH")
  CI = CountryCodeType.new("CI")
  CK = CountryCodeType.new("CK")
  CL = CountryCodeType.new("CL")
  CM = CountryCodeType.new("CM")
  CN = CountryCodeType.new("CN")
  CO = CountryCodeType.new("CO")
  CR = CountryCodeType.new("CR")
  CU = CountryCodeType.new("CU")
  CV = CountryCodeType.new("CV")
  CX = CountryCodeType.new("CX")
  CY = CountryCodeType.new("CY")
  CZ = CountryCodeType.new("CZ")
  CustomCode = CountryCodeType.new("CustomCode")
  DE = CountryCodeType.new("DE")
  DJ = CountryCodeType.new("DJ")
  DK = CountryCodeType.new("DK")
  DM = CountryCodeType.new("DM")
  DO = CountryCodeType.new("DO")
  DZ = CountryCodeType.new("DZ")
  EC = CountryCodeType.new("EC")
  EE = CountryCodeType.new("EE")
  EG = CountryCodeType.new("EG")
  EH = CountryCodeType.new("EH")
  ER = CountryCodeType.new("ER")
  ES = CountryCodeType.new("ES")
  ET = CountryCodeType.new("ET")
  FI = CountryCodeType.new("FI")
  FJ = CountryCodeType.new("FJ")
  FK = CountryCodeType.new("FK")
  FM = CountryCodeType.new("FM")
  FO = CountryCodeType.new("FO")
  FR = CountryCodeType.new("FR")
  GA = CountryCodeType.new("GA")
  GB = CountryCodeType.new("GB")
  GD = CountryCodeType.new("GD")
  GE = CountryCodeType.new("GE")
  GF = CountryCodeType.new("GF")
  GH = CountryCodeType.new("GH")
  GI = CountryCodeType.new("GI")
  GL = CountryCodeType.new("GL")
  GM = CountryCodeType.new("GM")
  GN = CountryCodeType.new("GN")
  GP = CountryCodeType.new("GP")
  GQ = CountryCodeType.new("GQ")
  GR = CountryCodeType.new("GR")
  GS = CountryCodeType.new("GS")
  GT = CountryCodeType.new("GT")
  GU = CountryCodeType.new("GU")
  GW = CountryCodeType.new("GW")
  GY = CountryCodeType.new("GY")
  HK = CountryCodeType.new("HK")
  HM = CountryCodeType.new("HM")
  HN = CountryCodeType.new("HN")
  HR = CountryCodeType.new("HR")
  HT = CountryCodeType.new("HT")
  HU = CountryCodeType.new("HU")
  ID = CountryCodeType.new("ID")
  IE = CountryCodeType.new("IE")
  IL = CountryCodeType.new("IL")
  IN = CountryCodeType.new("IN")
  IO = CountryCodeType.new("IO")
  IQ = CountryCodeType.new("IQ")
  IR = CountryCodeType.new("IR")
  IS = CountryCodeType.new("IS")
  IT = CountryCodeType.new("IT")
  JM = CountryCodeType.new("JM")
  JO = CountryCodeType.new("JO")
  JP = CountryCodeType.new("JP")
  KE = CountryCodeType.new("KE")
  KG = CountryCodeType.new("KG")
  KH = CountryCodeType.new("KH")
  KI = CountryCodeType.new("KI")
  KM = CountryCodeType.new("KM")
  KN = CountryCodeType.new("KN")
  KP = CountryCodeType.new("KP")
  KR = CountryCodeType.new("KR")
  KW = CountryCodeType.new("KW")
  KY = CountryCodeType.new("KY")
  KZ = CountryCodeType.new("KZ")
  LA = CountryCodeType.new("LA")
  LB = CountryCodeType.new("LB")
  LC = CountryCodeType.new("LC")
  LI = CountryCodeType.new("LI")
  LK = CountryCodeType.new("LK")
  LR = CountryCodeType.new("LR")
  LS = CountryCodeType.new("LS")
  LT = CountryCodeType.new("LT")
  LU = CountryCodeType.new("LU")
  LV = CountryCodeType.new("LV")
  LY = CountryCodeType.new("LY")
  MA = CountryCodeType.new("MA")
  MC = CountryCodeType.new("MC")
  MD = CountryCodeType.new("MD")
  MG = CountryCodeType.new("MG")
  MH = CountryCodeType.new("MH")
  MK = CountryCodeType.new("MK")
  ML = CountryCodeType.new("ML")
  MM = CountryCodeType.new("MM")
  MN = CountryCodeType.new("MN")
  MO = CountryCodeType.new("MO")
  MP = CountryCodeType.new("MP")
  MQ = CountryCodeType.new("MQ")
  MR = CountryCodeType.new("MR")
  MS = CountryCodeType.new("MS")
  MT = CountryCodeType.new("MT")
  MU = CountryCodeType.new("MU")
  MV = CountryCodeType.new("MV")
  MW = CountryCodeType.new("MW")
  MX = CountryCodeType.new("MX")
  MY = CountryCodeType.new("MY")
  MZ = CountryCodeType.new("MZ")
  NA = CountryCodeType.new("NA")
  NC = CountryCodeType.new("NC")
  NE = CountryCodeType.new("NE")
  NF = CountryCodeType.new("NF")
  NG = CountryCodeType.new("NG")
  NI = CountryCodeType.new("NI")
  NL = CountryCodeType.new("NL")
  NO = CountryCodeType.new("NO")
  NP = CountryCodeType.new("NP")
  NR = CountryCodeType.new("NR")
  NU = CountryCodeType.new("NU")
  NZ = CountryCodeType.new("NZ")
  OM = CountryCodeType.new("OM")
  PA = CountryCodeType.new("PA")
  PE = CountryCodeType.new("PE")
  PF = CountryCodeType.new("PF")
  PG = CountryCodeType.new("PG")
  PH = CountryCodeType.new("PH")
  PK = CountryCodeType.new("PK")
  PL = CountryCodeType.new("PL")
  PM = CountryCodeType.new("PM")
  PN = CountryCodeType.new("PN")
  PR = CountryCodeType.new("PR")
  PS = CountryCodeType.new("PS")
  PT = CountryCodeType.new("PT")
  PW = CountryCodeType.new("PW")
  PY = CountryCodeType.new("PY")
  QA = CountryCodeType.new("QA")
  QM = CountryCodeType.new("QM")
  QN = CountryCodeType.new("QN")
  QO = CountryCodeType.new("QO")
  QP = CountryCodeType.new("QP")
  RE = CountryCodeType.new("RE")
  RO = CountryCodeType.new("RO")
  RU = CountryCodeType.new("RU")
  RW = CountryCodeType.new("RW")
  SA = CountryCodeType.new("SA")
  SB = CountryCodeType.new("SB")
  SC = CountryCodeType.new("SC")
  SD = CountryCodeType.new("SD")
  SE = CountryCodeType.new("SE")
  SG = CountryCodeType.new("SG")
  SH = CountryCodeType.new("SH")
  SI = CountryCodeType.new("SI")
  SJ = CountryCodeType.new("SJ")
  SK = CountryCodeType.new("SK")
  SL = CountryCodeType.new("SL")
  SM = CountryCodeType.new("SM")
  SN = CountryCodeType.new("SN")
  SO = CountryCodeType.new("SO")
  SR = CountryCodeType.new("SR")
  ST = CountryCodeType.new("ST")
  SV = CountryCodeType.new("SV")
  SY = CountryCodeType.new("SY")
  SZ = CountryCodeType.new("SZ")
  TC = CountryCodeType.new("TC")
  TD = CountryCodeType.new("TD")
  TF = CountryCodeType.new("TF")
  TG = CountryCodeType.new("TG")
  TH = CountryCodeType.new("TH")
  TJ = CountryCodeType.new("TJ")
  TK = CountryCodeType.new("TK")
  TM = CountryCodeType.new("TM")
  TN = CountryCodeType.new("TN")
  TO = CountryCodeType.new("TO")
  TP = CountryCodeType.new("TP")
  TR = CountryCodeType.new("TR")
  TT = CountryCodeType.new("TT")
  TV = CountryCodeType.new("TV")
  TW = CountryCodeType.new("TW")
  TZ = CountryCodeType.new("TZ")
  UA = CountryCodeType.new("UA")
  UG = CountryCodeType.new("UG")
  UM = CountryCodeType.new("UM")
  US = CountryCodeType.new("US")
  UY = CountryCodeType.new("UY")
  UZ = CountryCodeType.new("UZ")
  VA = CountryCodeType.new("VA")
  VC = CountryCodeType.new("VC")
  VE = CountryCodeType.new("VE")
  VG = CountryCodeType.new("VG")
  VI = CountryCodeType.new("VI")
  VN = CountryCodeType.new("VN")
  VU = CountryCodeType.new("VU")
  WF = CountryCodeType.new("WF")
  WS = CountryCodeType.new("WS")
  YE = CountryCodeType.new("YE")
  YT = CountryCodeType.new("YT")
  YU = CountryCodeType.new("YU")
  ZA = CountryCodeType.new("ZA")
  ZM = CountryCodeType.new("ZM")
  ZW = CountryCodeType.new("ZW")
end

# {urn:ebay:apis:eBLBaseComponents}CurrencyCodeType
class CurrencyCodeType < ::String
  @@schema_type = "CurrencyCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  ADP = CurrencyCodeType.new("ADP")
  AED = CurrencyCodeType.new("AED")
  AFA = CurrencyCodeType.new("AFA")
  ALL = CurrencyCodeType.new("ALL")
  AMD = CurrencyCodeType.new("AMD")
  ANG = CurrencyCodeType.new("ANG")
  AOA = CurrencyCodeType.new("AOA")
  ARS = CurrencyCodeType.new("ARS")
  AUD = CurrencyCodeType.new("AUD")
  AWG = CurrencyCodeType.new("AWG")
  AZM = CurrencyCodeType.new("AZM")
  BAM = CurrencyCodeType.new("BAM")
  BBD = CurrencyCodeType.new("BBD")
  BDT = CurrencyCodeType.new("BDT")
  BGL = CurrencyCodeType.new("BGL")
  BGN = CurrencyCodeType.new("BGN")
  BHD = CurrencyCodeType.new("BHD")
  BIF = CurrencyCodeType.new("BIF")
  BMD = CurrencyCodeType.new("BMD")
  BND = CurrencyCodeType.new("BND")
  BOB = CurrencyCodeType.new("BOB")
  BOV = CurrencyCodeType.new("BOV")
  BRL = CurrencyCodeType.new("BRL")
  BSD = CurrencyCodeType.new("BSD")
  BTN = CurrencyCodeType.new("BTN")
  BWP = CurrencyCodeType.new("BWP")
  BYR = CurrencyCodeType.new("BYR")
  BZD = CurrencyCodeType.new("BZD")
  CAD = CurrencyCodeType.new("CAD")
  CDF = CurrencyCodeType.new("CDF")
  CHF = CurrencyCodeType.new("CHF")
  CLF = CurrencyCodeType.new("CLF")
  CLP = CurrencyCodeType.new("CLP")
  CNY = CurrencyCodeType.new("CNY")
  COP = CurrencyCodeType.new("COP")
  CRC = CurrencyCodeType.new("CRC")
  CUP = CurrencyCodeType.new("CUP")
  CVE = CurrencyCodeType.new("CVE")
  CYP = CurrencyCodeType.new("CYP")
  CZK = CurrencyCodeType.new("CZK")
  CustomCode = CurrencyCodeType.new("CustomCode")
  DJF = CurrencyCodeType.new("DJF")
  DKK = CurrencyCodeType.new("DKK")
  DOP = CurrencyCodeType.new("DOP")
  DZD = CurrencyCodeType.new("DZD")
  ECS = CurrencyCodeType.new("ECS")
  ECV = CurrencyCodeType.new("ECV")
  EEK = CurrencyCodeType.new("EEK")
  EGP = CurrencyCodeType.new("EGP")
  ERN = CurrencyCodeType.new("ERN")
  ETB = CurrencyCodeType.new("ETB")
  EUR = CurrencyCodeType.new("EUR")
  FJD = CurrencyCodeType.new("FJD")
  FKP = CurrencyCodeType.new("FKP")
  GBP = CurrencyCodeType.new("GBP")
  GEL = CurrencyCodeType.new("GEL")
  GHC = CurrencyCodeType.new("GHC")
  GIP = CurrencyCodeType.new("GIP")
  GMD = CurrencyCodeType.new("GMD")
  GNF = CurrencyCodeType.new("GNF")
  GTQ = CurrencyCodeType.new("GTQ")
  GWP = CurrencyCodeType.new("GWP")
  GYD = CurrencyCodeType.new("GYD")
  HKD = CurrencyCodeType.new("HKD")
  HNL = CurrencyCodeType.new("HNL")
  HRK = CurrencyCodeType.new("HRK")
  HTG = CurrencyCodeType.new("HTG")
  HUF = CurrencyCodeType.new("HUF")
  IDR = CurrencyCodeType.new("IDR")
  ILS = CurrencyCodeType.new("ILS")
  INR = CurrencyCodeType.new("INR")
  IQD = CurrencyCodeType.new("IQD")
  IRR = CurrencyCodeType.new("IRR")
  ISK = CurrencyCodeType.new("ISK")
  JMD = CurrencyCodeType.new("JMD")
  JOD = CurrencyCodeType.new("JOD")
  JPY = CurrencyCodeType.new("JPY")
  KES = CurrencyCodeType.new("KES")
  KGS = CurrencyCodeType.new("KGS")
  KHR = CurrencyCodeType.new("KHR")
  KMF = CurrencyCodeType.new("KMF")
  KPW = CurrencyCodeType.new("KPW")
  KRW = CurrencyCodeType.new("KRW")
  KWD = CurrencyCodeType.new("KWD")
  KYD = CurrencyCodeType.new("KYD")
  KZT = CurrencyCodeType.new("KZT")
  LAK = CurrencyCodeType.new("LAK")
  LBP = CurrencyCodeType.new("LBP")
  LKR = CurrencyCodeType.new("LKR")
  LRD = CurrencyCodeType.new("LRD")
  LSL = CurrencyCodeType.new("LSL")
  LTL = CurrencyCodeType.new("LTL")
  LVL = CurrencyCodeType.new("LVL")
  LYD = CurrencyCodeType.new("LYD")
  MAD = CurrencyCodeType.new("MAD")
  MDL = CurrencyCodeType.new("MDL")
  MGF = CurrencyCodeType.new("MGF")
  MKD = CurrencyCodeType.new("MKD")
  MMK = CurrencyCodeType.new("MMK")
  MNT = CurrencyCodeType.new("MNT")
  MOP = CurrencyCodeType.new("MOP")
  MRO = CurrencyCodeType.new("MRO")
  MTL = CurrencyCodeType.new("MTL")
  MUR = CurrencyCodeType.new("MUR")
  MVR = CurrencyCodeType.new("MVR")
  MWK = CurrencyCodeType.new("MWK")
  MXN = CurrencyCodeType.new("MXN")
  MXV = CurrencyCodeType.new("MXV")
  MYR = CurrencyCodeType.new("MYR")
  MZM = CurrencyCodeType.new("MZM")
  NAD = CurrencyCodeType.new("NAD")
  NGN = CurrencyCodeType.new("NGN")
  NIO = CurrencyCodeType.new("NIO")
  NOK = CurrencyCodeType.new("NOK")
  NPR = CurrencyCodeType.new("NPR")
  NZD = CurrencyCodeType.new("NZD")
  OMR = CurrencyCodeType.new("OMR")
  PAB = CurrencyCodeType.new("PAB")
  PEN = CurrencyCodeType.new("PEN")
  PGK = CurrencyCodeType.new("PGK")
  PHP = CurrencyCodeType.new("PHP")
  PKR = CurrencyCodeType.new("PKR")
  PLN = CurrencyCodeType.new("PLN")
  PYG = CurrencyCodeType.new("PYG")
  QAR = CurrencyCodeType.new("QAR")
  ROL = CurrencyCodeType.new("ROL")
  RUB = CurrencyCodeType.new("RUB")
  RUR = CurrencyCodeType.new("RUR")
  RWF = CurrencyCodeType.new("RWF")
  SAR = CurrencyCodeType.new("SAR")
  SBD = CurrencyCodeType.new("SBD")
  SCR = CurrencyCodeType.new("SCR")
  SDD = CurrencyCodeType.new("SDD")
  SEK = CurrencyCodeType.new("SEK")
  SGD = CurrencyCodeType.new("SGD")
  SHP = CurrencyCodeType.new("SHP")
  SIT = CurrencyCodeType.new("SIT")
  SKK = CurrencyCodeType.new("SKK")
  SLL = CurrencyCodeType.new("SLL")
  SOS = CurrencyCodeType.new("SOS")
  SRG = CurrencyCodeType.new("SRG")
  STD = CurrencyCodeType.new("STD")
  SVC = CurrencyCodeType.new("SVC")
  SYP = CurrencyCodeType.new("SYP")
  SZL = CurrencyCodeType.new("SZL")
  THB = CurrencyCodeType.new("THB")
  TJS = CurrencyCodeType.new("TJS")
  TMM = CurrencyCodeType.new("TMM")
  TND = CurrencyCodeType.new("TND")
  TOP = CurrencyCodeType.new("TOP")
  TPE = CurrencyCodeType.new("TPE")
  TRL = CurrencyCodeType.new("TRL")
  TTD = CurrencyCodeType.new("TTD")
  TWD = CurrencyCodeType.new("TWD")
  TZS = CurrencyCodeType.new("TZS")
  UAH = CurrencyCodeType.new("UAH")
  UGX = CurrencyCodeType.new("UGX")
  USD = CurrencyCodeType.new("USD")
  USN = CurrencyCodeType.new("USN")
  USS = CurrencyCodeType.new("USS")
  UYU = CurrencyCodeType.new("UYU")
  UZS = CurrencyCodeType.new("UZS")
  VEB = CurrencyCodeType.new("VEB")
  VND = CurrencyCodeType.new("VND")
  VUV = CurrencyCodeType.new("VUV")
  WST = CurrencyCodeType.new("WST")
  XAF = CurrencyCodeType.new("XAF")
  XCD = CurrencyCodeType.new("XCD")
  XOF = CurrencyCodeType.new("XOF")
  XPF = CurrencyCodeType.new("XPF")
  YER = CurrencyCodeType.new("YER")
  YUM = CurrencyCodeType.new("YUM")
  ZAR = CurrencyCodeType.new("ZAR")
  ZMK = CurrencyCodeType.new("ZMK")
  ZWD = CurrencyCodeType.new("ZWD")
end

# {urn:ebay:apis:eBLBaseComponents}DepositTypeCodeType
class DepositTypeCodeType < ::String
  @@schema_type = "DepositTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = DepositTypeCodeType.new("CustomCode")
  FastDeposit = DepositTypeCodeType.new("FastDeposit")
  None = DepositTypeCodeType.new("None")
  OtherMethod = DepositTypeCodeType.new("OtherMethod")
end

# {urn:ebay:apis:eBLBaseComponents}DetailLevelCodeType
class DetailLevelCodeType < ::String
  @@schema_type = "DetailLevelCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  ItemReturnAttributes = DetailLevelCodeType.new("ItemReturnAttributes")
  ItemReturnDescription = DetailLevelCodeType.new("ItemReturnDescription")
  ReturnAll = DetailLevelCodeType.new("ReturnAll")
end

# {urn:ebay:apis:eBLBaseComponents}EscrowCodeType
class EscrowCodeType < ::String
  @@schema_type = "EscrowCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  ByBuyer = EscrowCodeType.new("ByBuyer")
  BySeller = EscrowCodeType.new("BySeller")
  CustomCode = EscrowCodeType.new("CustomCode")
  None = EscrowCodeType.new("None")
end

# {urn:ebay:apis:eBLBaseComponents}FeedbackRatingStarCodeType
class FeedbackRatingStarCodeType < ::String
  @@schema_type = "FeedbackRatingStarCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Blue = FeedbackRatingStarCodeType.new("Blue")
  CustomCode = FeedbackRatingStarCodeType.new("CustomCode")
  Green = FeedbackRatingStarCodeType.new("Green")
  None = FeedbackRatingStarCodeType.new("None")
  Purple = FeedbackRatingStarCodeType.new("Purple")
  PurpleShooting = FeedbackRatingStarCodeType.new("PurpleShooting")
  Red = FeedbackRatingStarCodeType.new("Red")
  RedShooting = FeedbackRatingStarCodeType.new("RedShooting")
  Turquoise = FeedbackRatingStarCodeType.new("Turquoise")
  TurquoiseShooting = FeedbackRatingStarCodeType.new("TurquoiseShooting")
  Yellow = FeedbackRatingStarCodeType.new("Yellow")
  YellowShooting = FeedbackRatingStarCodeType.new("YellowShooting")
end

# {urn:ebay:apis:eBLBaseComponents}GalleryTypeCodeType
class GalleryTypeCodeType < ::String
  @@schema_type = "GalleryTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = GalleryTypeCodeType.new("CustomCode")
  Featured = GalleryTypeCodeType.new("Featured")
  Gallery = GalleryTypeCodeType.new("Gallery")
end

# {urn:ebay:apis:eBLBaseComponents}GeneralPaymentMethodCodeType
class GeneralPaymentMethodCodeType < ::String
  @@schema_type = "GeneralPaymentMethodCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  ACH = GeneralPaymentMethodCodeType.new("ACH")
  Creditcard = GeneralPaymentMethodCodeType.new("Creditcard")
  CustomCode = GeneralPaymentMethodCodeType.new("CustomCode")
  Echeck = GeneralPaymentMethodCodeType.new("Echeck")
  Other = GeneralPaymentMethodCodeType.new("Other")
  PayPalBalance = GeneralPaymentMethodCodeType.new("PayPalBalance")
end

# {urn:ebay:apis:eBLBaseComponents}GiftServicesCodeType
class GiftServicesCodeType < ::String
  @@schema_type = "GiftServicesCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = GiftServicesCodeType.new("CustomCode")
  GiftExpressShipping = GiftServicesCodeType.new("GiftExpressShipping")
  GiftShipToRecipient = GiftServicesCodeType.new("GiftShipToRecipient")
  GiftWrap = GiftServicesCodeType.new("GiftWrap")
end

# {urn:ebay:apis:eBLBaseComponents}HitCounterCodeType
class HitCounterCodeType < ::String
  @@schema_type = "HitCounterCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = HitCounterCodeType.new("CustomCode")
  GreenLED = HitCounterCodeType.new("GreenLED")
  Hidden = HitCounterCodeType.new("Hidden")
  HonestyStyle = HitCounterCodeType.new("HonestyStyle")
  NoHitCounter = HitCounterCodeType.new("NoHitCounter")
end

# {urn:ebay:apis:eBLBaseComponents}InsuranceOptionCodeType
class InsuranceOptionCodeType < ::String
  @@schema_type = "InsuranceOptionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = InsuranceOptionCodeType.new("CustomCode")
  IncludedInShippingHandling = InsuranceOptionCodeType.new("IncludedInShippingHandling")
  NotOffered = InsuranceOptionCodeType.new("NotOffered")
  Optional = InsuranceOptionCodeType.new("Optional")
  Required = InsuranceOptionCodeType.new("Required")
end

# {urn:ebay:apis:eBLBaseComponents}ListingDurationCodeType
class ListingDurationCodeType < ::String
  @@schema_type = "ListingDurationCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = ListingDurationCodeType.new("CustomCode")
  Days_1 = ListingDurationCodeType.new("Days_1")
  Days_10 = ListingDurationCodeType.new("Days_10")
  Days_120 = ListingDurationCodeType.new("Days_120")
  Days_3 = ListingDurationCodeType.new("Days_3")
  Days_30 = ListingDurationCodeType.new("Days_30")
  Days_5 = ListingDurationCodeType.new("Days_5")
  Days_60 = ListingDurationCodeType.new("Days_60")
  Days_7 = ListingDurationCodeType.new("Days_7")
  Days_90 = ListingDurationCodeType.new("Days_90")
  GTC = ListingDurationCodeType.new("GTC")
end

# {urn:ebay:apis:eBLBaseComponents}ListingEnhancementsCodeType
class ListingEnhancementsCodeType < ::String
  @@schema_type = "ListingEnhancementsCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  BoldTitle = ListingEnhancementsCodeType.new("BoldTitle")
  Border = ListingEnhancementsCodeType.new("Border")
  CustomCode = ListingEnhancementsCodeType.new("CustomCode")
  Featured = ListingEnhancementsCodeType.new("Featured")
  Highlight = ListingEnhancementsCodeType.new("Highlight")
  HomePageFeatured = ListingEnhancementsCodeType.new("HomePageFeatured")
end

# {urn:ebay:apis:eBLBaseComponents}ListingTypeCodeType
class ListingTypeCodeType < ::String
  @@schema_type = "ListingTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AdType = ListingTypeCodeType.new("AdType")
  Chinese = ListingTypeCodeType.new("Chinese")
  CustomCode = ListingTypeCodeType.new("CustomCode")
  Dutch = ListingTypeCodeType.new("Dutch")
  FixedPriceItem = ListingTypeCodeType.new("FixedPriceItem")
  Live = ListingTypeCodeType.new("Live")
  PersonalOffer = ListingTypeCodeType.new("PersonalOffer")
  StoresFixedPrice = ListingTypeCodeType.new("StoresFixedPrice")
  Unknown = ListingTypeCodeType.new("Unknown")
end

# {urn:ebay:apis:eBLBaseComponents}MerchandizingPrefCodeType
class MerchandizingPrefCodeType < ::String
  @@schema_type = "MerchandizingPrefCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = MerchandizingPrefCodeType.new("CustomCode")
  OptIn = MerchandizingPrefCodeType.new("OptIn")
  OptOut = MerchandizingPrefCodeType.new("OptOut")
end

# {urn:ebay:apis:eBLBaseComponents}ModifyCodeType
class ModifyCodeType < ::String
  @@schema_type = "ModifyCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = ModifyCodeType.new("CustomCode")
  Dropped = ModifyCodeType.new("Dropped")
  Modify = ModifyCodeType.new("Modify")
end

# {urn:ebay:apis:eBLBaseComponents}PhotoDisplayCodeType
class PhotoDisplayCodeType < ::String
  @@schema_type = "PhotoDisplayCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = PhotoDisplayCodeType.new("CustomCode")
  None = PhotoDisplayCodeType.new("None")
  PicturePack = PhotoDisplayCodeType.new("PicturePack")
  SlideShow = PhotoDisplayCodeType.new("SlideShow")
  SuperSize = PhotoDisplayCodeType.new("SuperSize")
end

# {urn:ebay:apis:eBLBaseComponents}PromotionItemPriceTypeCodeType
class PromotionItemPriceTypeCodeType < ::String
  @@schema_type = "PromotionItemPriceTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AuctionPrice = PromotionItemPriceTypeCodeType.new("AuctionPrice")
  BuyItNowPrice = PromotionItemPriceTypeCodeType.new("BuyItNowPrice")
  CustomCode = PromotionItemPriceTypeCodeType.new("CustomCode")
end

# {urn:ebay:apis:eBLBaseComponents}PromotionItemSelectionCodeType
class PromotionItemSelectionCodeType < ::String
  @@schema_type = "PromotionItemSelectionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Automatic = PromotionItemSelectionCodeType.new("Automatic")
  CustomCode = PromotionItemSelectionCodeType.new("CustomCode")
  Manual = PromotionItemSelectionCodeType.new("Manual")
end

# {urn:ebay:apis:eBLBaseComponents}PromotionMethodCodeType
class PromotionMethodCodeType < ::String
  @@schema_type = "PromotionMethodCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CrossSell = PromotionMethodCodeType.new("CrossSell")
  CustomCode = PromotionMethodCodeType.new("CustomCode")
  UpSell = PromotionMethodCodeType.new("UpSell")
end

# {urn:ebay:apis:eBLBaseComponents}PromotionSchemeCodeType
class PromotionSchemeCodeType < ::String
  @@schema_type = "PromotionSchemeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = PromotionSchemeCodeType.new("CustomCode")
  ItemToItem = PromotionSchemeCodeType.new("ItemToItem")
  ItemToStoreCat = PromotionSchemeCodeType.new("ItemToStoreCat")
  StoreToStoreCat = PromotionSchemeCodeType.new("StoreToStoreCat")
end

# {urn:ebay:apis:eBLBaseComponents}PurchasePurposeTypeCodeType
class PurchasePurposeTypeCodeType < ::String
  @@schema_type = "PurchasePurposeTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AuctionItem = PurchasePurposeTypeCodeType.new("AuctionItem")
  BuyNowItem = PurchasePurposeTypeCodeType.new("BuyNowItem")
  CustomCode = PurchasePurposeTypeCodeType.new("CustomCode")
  Donation = PurchasePurposeTypeCodeType.new("Donation")
  EBayBilling = PurchasePurposeTypeCodeType.new("eBayBilling")
  GiftCertificates = PurchasePurposeTypeCodeType.new("GiftCertificates")
  Other = PurchasePurposeTypeCodeType.new("Other")
  ShoppingCart = PurchasePurposeTypeCodeType.new("ShoppingCart")
  Subscription = PurchasePurposeTypeCodeType.new("Subscription")
end

# {urn:ebay:apis:eBLBaseComponents}SellerLevelCodeType
class SellerLevelCodeType < ::String
  @@schema_type = "SellerLevelCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Bronze = SellerLevelCodeType.new("Bronze")
  CustomCode = SellerLevelCodeType.new("CustomCode")
  Gold = SellerLevelCodeType.new("Gold")
  None = SellerLevelCodeType.new("None")
  Platinum = SellerLevelCodeType.new("Platinum")
  Silver = SellerLevelCodeType.new("Silver")
  Titanium = SellerLevelCodeType.new("Titanium")
end

# {urn:ebay:apis:eBLBaseComponents}SellerPaymentMethodCodeType
class SellerPaymentMethodCodeType < ::String
  @@schema_type = "SellerPaymentMethodCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Amex = SellerPaymentMethodCodeType.new("Amex")
  CustomCode = SellerPaymentMethodCodeType.new("CustomCode")
  Diners = SellerPaymentMethodCodeType.new("Diners")
  Discover = SellerPaymentMethodCodeType.new("Discover")
  JCB = SellerPaymentMethodCodeType.new("JCB")
  Mastercard = SellerPaymentMethodCodeType.new("Mastercard")
  Other = SellerPaymentMethodCodeType.new("Other")
  Visa = SellerPaymentMethodCodeType.new("Visa")
end

# {urn:ebay:apis:eBLBaseComponents}SeverityCodeType
class SeverityCodeType < ::String
  @@schema_type = "SeverityCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = SeverityCodeType.new("CustomCode")
  Error = SeverityCodeType.new("Error")
  Warning = SeverityCodeType.new("Warning")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingOptionCodeType
class ShippingOptionCodeType < ::String
  @@schema_type = "ShippingOptionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = ShippingOptionCodeType.new("CustomCode")
  SiteOnly = ShippingOptionCodeType.new("SiteOnly")
  SitePlusRegions = ShippingOptionCodeType.new("SitePlusRegions")
  WillNotShip = ShippingOptionCodeType.new("WillNotShip")
  WorldWide = ShippingOptionCodeType.new("WorldWide")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingPackageCodeType
class ShippingPackageCodeType < ::String
  @@schema_type = "ShippingPackageCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = ShippingPackageCodeType.new("CustomCode")
  LargeEnvelope = ShippingPackageCodeType.new("LargeEnvelope")
  Letter = ShippingPackageCodeType.new("Letter")
  None = ShippingPackageCodeType.new("None")
  PackageThickEnvelope = ShippingPackageCodeType.new("PackageThickEnvelope")
  UPSLetter = ShippingPackageCodeType.new("UPSLetter")
  USPSFlatRateEnvelope = ShippingPackageCodeType.new("USPSFlatRateEnvelope")
  USPSLargePack = ShippingPackageCodeType.new("USPSLargePack")
  VeryLargePack = ShippingPackageCodeType.new("VeryLargePack")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingRatesTypeCodeType
class ShippingRatesTypeCodeType < ::String
  @@schema_type = "ShippingRatesTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Calculated = ShippingRatesTypeCodeType.new("Calculated")
  CustomCode = ShippingRatesTypeCodeType.new("CustomCode")
  Flat = ShippingRatesTypeCodeType.new("Flat")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingRegionCodeType
class ShippingRegionCodeType < ::String
  @@schema_type = "ShippingRegionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Africa = ShippingRegionCodeType.new("Africa")
  Asia = ShippingRegionCodeType.new("Asia")
  Caribbean = ShippingRegionCodeType.new("Caribbean")
  CustomCode = ShippingRegionCodeType.new("CustomCode")
  Europe = ShippingRegionCodeType.new("Europe")
  LatinAmerica = ShippingRegionCodeType.new("LatinAmerica")
  MiddleEast = ShippingRegionCodeType.new("MiddleEast")
  NorthAmerica = ShippingRegionCodeType.new("NorthAmerica")
  Oceania = ShippingRegionCodeType.new("Oceania")
  SouthAmerica = ShippingRegionCodeType.new("SouthAmerica")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingServiceCodeType
class ShippingServiceCodeType < ::String
  @@schema_type = "ShippingServiceCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = ShippingServiceCodeType.new("CustomCode")
  ShippingMethodExpress = ShippingServiceCodeType.new("ShippingMethodExpress")
  ShippingMethodNextDay = ShippingServiceCodeType.new("ShippingMethodNextDay")
  ShippingMethodStandard = ShippingServiceCodeType.new("ShippingMethodStandard")
  UPS2ndDay = ShippingServiceCodeType.new("UPS2ndDay")
  UPS3rdDay = ShippingServiceCodeType.new("UPS3rdDay")
  UPSGround = ShippingServiceCodeType.new("UPSGround")
  UPSNextDay = ShippingServiceCodeType.new("UPSNextDay")
  USPSExpressMail = ShippingServiceCodeType.new("USPSExpressMail")
  USPSFirstClass = ShippingServiceCodeType.new("USPSFirstClass")
  USPSGround = ShippingServiceCodeType.new("USPSGround")
  USPSMedia = ShippingServiceCodeType.new("USPSMedia")
  USPSParcel = ShippingServiceCodeType.new("USPSParcel")
  USPSPriority = ShippingServiceCodeType.new("USPSPriority")
end

# {urn:ebay:apis:eBLBaseComponents}ShippingTermsCodeType
class ShippingTermsCodeType < ::String
  @@schema_type = "ShippingTermsCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  BuyerPays = ShippingTermsCodeType.new("BuyerPays")
  CustomCode = ShippingTermsCodeType.new("CustomCode")
  SellerPays = ShippingTermsCodeType.new("SellerPays")
end

# {urn:ebay:apis:eBLBaseComponents}SiteCodeType
class SiteCodeType < ::String
  @@schema_type = "SiteCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Australia = SiteCodeType.new("Australia")
  Austria = SiteCodeType.new("Austria")
  Belgium_Dutch = SiteCodeType.new("Belgium_Dutch")
  Belgium_French = SiteCodeType.new("Belgium_French")
  Canada = SiteCodeType.new("Canada")
  CustomCode = SiteCodeType.new("CustomCode")
  EBayMotors = SiteCodeType.new("eBayMotors")
  France = SiteCodeType.new("France")
  Germany = SiteCodeType.new("Germany")
  HongKong = SiteCodeType.new("HongKong")
  Italy = SiteCodeType.new("Italy")
  Netherlands = SiteCodeType.new("Netherlands")
  Singapore = SiteCodeType.new("Singapore")
  Spain = SiteCodeType.new("Spain")
  Switzerland = SiteCodeType.new("Switzerland")
  Taiwan = SiteCodeType.new("Taiwan")
  UK = SiteCodeType.new("UK")
  US = SiteCodeType.new("US")
end

# {urn:ebay:apis:eBLBaseComponents}UnitCodeType
class UnitCodeType < ::String
  @@schema_type = "UnitCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Cm = UnitCodeType.new("cm")
  CustomCode = UnitCodeType.new("CustomCode")
  Ft = UnitCodeType.new("ft")
  Inches = UnitCodeType.new("inches")
  Kg = UnitCodeType.new("kg")
  Lbs = UnitCodeType.new("lbs")
  Oz = UnitCodeType.new("oz")
end

# {urn:ebay:apis:eBLBaseComponents}UserStatusCodeType
class UserStatusCodeType < ::String
  @@schema_type = "UserStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AccountOnHold = UserStatusCodeType.new("AccountOnHold")
  Confirmed = UserStatusCodeType.new("Confirmed")
  CreditCardVerify = UserStatusCodeType.new("CreditCardVerify")
  CreditCardVerifyHalfOptIn = UserStatusCodeType.new("CreditCardVerifyHalfOptIn")
  CreditCardVerifyPassport = UserStatusCodeType.new("CreditCardVerifyPassport")
  CustomCode = UserStatusCodeType.new("CustomCode")
  Deleted = UserStatusCodeType.new("Deleted")
  Ghost = UserStatusCodeType.new("Ghost")
  InMaintenance = UserStatusCodeType.new("InMaintenance")
  Merged = UserStatusCodeType.new("Merged")
  RegistrationCodeMailOut = UserStatusCodeType.new("RegistrationCodeMailOut")
  Suspended = UserStatusCodeType.new("Suspended")
  TermPending = UserStatusCodeType.new("TermPending")
  Unconfirmed = UserStatusCodeType.new("Unconfirmed")
  UnconfirmedExpress = UserStatusCodeType.new("UnconfirmedExpress")
  UnconfirmedHalfOptIn = UserStatusCodeType.new("UnconfirmedHalfOptIn")
  UnconfirmedPassport = UserStatusCodeType.new("UnconfirmedPassport")
  Unknown = UserStatusCodeType.new("Unknown")
end

# {urn:ebay:apis:eBLBaseComponents}VATStatusCodeType
class VATStatusCodeType < ::String
  @@schema_type = "VATStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CustomCode = VATStatusCodeType.new("CustomCode")
  NoVATTax = VATStatusCodeType.new("NoVATTax")
  VATExempt = VATStatusCodeType.new("VATExempt")
  VATTax = VATStatusCodeType.new("VATTax")
end

# {urn:ebay:apis:eBLBaseComponents}CreditCardTypeType
class CreditCardTypeType < ::String
  @@schema_type = "CreditCardTypeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Amex = CreditCardTypeType.new("Amex")
  Discover = CreditCardTypeType.new("Discover")
  MasterCard = CreditCardTypeType.new("MasterCard")
  Visa = CreditCardTypeType.new("Visa")
end

# {urn:ebay:apis:eBLBaseComponents}RefundPurposeTypeCodeType
class RefundPurposeTypeCodeType < ::String
  @@schema_type = "RefundPurposeTypeCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Full = RefundPurposeTypeCodeType.new("Full")
  Other = RefundPurposeTypeCodeType.new("Other")
  Partial = RefundPurposeTypeCodeType.new("Partial")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentNotificationServiceCodeType
class PaymentNotificationServiceCodeType < ::String
  @@schema_type = "PaymentNotificationServiceCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  EBayCN = PaymentNotificationServiceCodeType.new("eBayCN")
end

# {urn:ebay:apis:eBLBaseComponents}BankIDCodeType
class BankIDCodeType < ::String
  @@schema_type = "BankIDCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CCB = BankIDCodeType.new("CCB")
  CMB = BankIDCodeType.new("CMB")
  ChinaPay = BankIDCodeType.new("ChinaPay")
  ICBC = BankIDCodeType.new("ICBC")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentTransactionCodeType
class PaymentTransactionCodeType < ::String
  @@schema_type = "PaymentTransactionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Cart = PaymentTransactionCodeType.new("cart")
  ExpressCheckout = PaymentTransactionCodeType.new("express-checkout")
  MassPay = PaymentTransactionCodeType.new("mass-pay")
  MerchtPmt = PaymentTransactionCodeType.new("mercht-pmt")
  None = PaymentTransactionCodeType.new("none")
  SendMoney = PaymentTransactionCodeType.new("send-money")
  SubscrCancel = PaymentTransactionCodeType.new("subscr-cancel")
  SubscrEot = PaymentTransactionCodeType.new("subscr-eot")
  SubscrFailed = PaymentTransactionCodeType.new("subscr-failed")
  SubscrModify = PaymentTransactionCodeType.new("subscr-modify")
  SubscrPayment = PaymentTransactionCodeType.new("subscr-payment")
  SubscrSignup = PaymentTransactionCodeType.new("subscr-signup")
  VirtualTerminal = PaymentTransactionCodeType.new("virtual-terminal")
  WebAccept = PaymentTransactionCodeType.new("web-accept")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentStatusCodeType
class PaymentStatusCodeType < ::String
  @@schema_type = "PaymentStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  CanceledReversal = PaymentStatusCodeType.new("Canceled-Reversal")
  Completed = PaymentStatusCodeType.new("Completed")
  Denied = PaymentStatusCodeType.new("Denied")
  Expired = PaymentStatusCodeType.new("Expired")
  Failed = PaymentStatusCodeType.new("Failed")
  InProgress = PaymentStatusCodeType.new("In-Progress")
  None = PaymentStatusCodeType.new("None")
  PartiallyRefunded = PaymentStatusCodeType.new("Partially-Refunded")
  Pending = PaymentStatusCodeType.new("Pending")
  Processed = PaymentStatusCodeType.new("Processed")
  Refunded = PaymentStatusCodeType.new("Refunded")
  Reversed = PaymentStatusCodeType.new("Reversed")
  Voided = PaymentStatusCodeType.new("Voided")
end

# {urn:ebay:apis:eBLBaseComponents}AddressStatusCodeType
class AddressStatusCodeType < ::String
  @@schema_type = "AddressStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Confirmed = AddressStatusCodeType.new("Confirmed")
  None = AddressStatusCodeType.new("None")
  Unconfirmed = AddressStatusCodeType.new("Unconfirmed")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentActionCodeType
class PaymentActionCodeType < ::String
  @@schema_type = "PaymentActionCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Authorization = PaymentActionCodeType.new("Authorization")
  None = PaymentActionCodeType.new("None")
  Order = PaymentActionCodeType.new("Order")
  Sale = PaymentActionCodeType.new("Sale")
end

# {urn:ebay:apis:eBLBaseComponents}PendingStatusCodeType
class PendingStatusCodeType < ::String
  @@schema_type = "PendingStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Address = PendingStatusCodeType.new("address")
  Authorization = PendingStatusCodeType.new("authorization")
  Echeck = PendingStatusCodeType.new("echeck")
  Intl = PendingStatusCodeType.new("intl")
  MultiCurrency = PendingStatusCodeType.new("multi-currency")
  None = PendingStatusCodeType.new("none")
  Order = PendingStatusCodeType.new("order")
  Other = PendingStatusCodeType.new("other")
  Unilateral = PendingStatusCodeType.new("unilateral")
  Upgrade = PendingStatusCodeType.new("upgrade")
  Verify = PendingStatusCodeType.new("verify")
end

# {urn:ebay:apis:eBLBaseComponents}ReceiverInfoCodeType
class ReceiverInfoCodeType < ::String
  @@schema_type = "ReceiverInfoCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  EmailAddress = ReceiverInfoCodeType.new("EmailAddress")
  UserID = ReceiverInfoCodeType.new("UserID")
end

# {urn:ebay:apis:eBLBaseComponents}ReversalReasonCodeType
class ReversalReasonCodeType < ::String
  @@schema_type = "ReversalReasonCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  BuyerComplaint = ReversalReasonCodeType.new("buyer-complaint")
  Chargeback = ReversalReasonCodeType.new("chargeback")
  Guarantee = ReversalReasonCodeType.new("guarantee")
  None = ReversalReasonCodeType.new("none")
  Other = ReversalReasonCodeType.new("other")
  Refund = ReversalReasonCodeType.new("refund")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentCodeType
class PaymentCodeType < ::String
  @@schema_type = "PaymentCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Echeck = PaymentCodeType.new("echeck")
  Instant = PaymentCodeType.new("instant")
  None = PaymentCodeType.new("none")
end

# {urn:ebay:apis:eBLBaseComponents}PayPalUserStatusCodeType
class PayPalUserStatusCodeType < ::String
  @@schema_type = "PayPalUserStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Unverified = PayPalUserStatusCodeType.new("unverified")
  Verified = PayPalUserStatusCodeType.new("verified")
end

# {urn:ebay:apis:eBLBaseComponents}MerchantPullPaymentCodeType
class MerchantPullPaymentCodeType < ::String
  @@schema_type = "MerchantPullPaymentCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Any = MerchantPullPaymentCodeType.new("Any")
  EcheckOnly = MerchantPullPaymentCodeType.new("EcheckOnly")
  InstantOnly = MerchantPullPaymentCodeType.new("InstantOnly")
end

# {urn:ebay:apis:eBLBaseComponents}MerchantPullStatusCodeType
class MerchantPullStatusCodeType < ::String
  @@schema_type = "MerchantPullStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Active = MerchantPullStatusCodeType.new("Active")
  Canceled = MerchantPullStatusCodeType.new("Canceled")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentTransactionStatusCodeType
class PaymentTransactionStatusCodeType < ::String
  @@schema_type = "PaymentTransactionStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Denied = PaymentTransactionStatusCodeType.new("Denied")
  Pending = PaymentTransactionStatusCodeType.new("Pending")
  Processing = PaymentTransactionStatusCodeType.new("Processing")
  Reversed = PaymentTransactionStatusCodeType.new("Reversed")
  Success = PaymentTransactionStatusCodeType.new("Success")
end

# {urn:ebay:apis:eBLBaseComponents}PaymentTransactionClassCodeType
class PaymentTransactionClassCodeType < ::String
  @@schema_type = "PaymentTransactionClassCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  All = PaymentTransactionClassCodeType.new("All")
  BalanceAffecting = PaymentTransactionClassCodeType.new("BalanceAffecting")
  BalanceTransfer = PaymentTransactionClassCodeType.new("BalanceTransfer")
  Billpay = PaymentTransactionClassCodeType.new("Billpay")
  CurrencyConversions = PaymentTransactionClassCodeType.new("CurrencyConversions")
  Dividend = PaymentTransactionClassCodeType.new("Dividend")
  ECheck = PaymentTransactionClassCodeType.new("ECheck")
  Fee = PaymentTransactionClassCodeType.new("Fee")
  FundsAdded = PaymentTransactionClassCodeType.new("FundsAdded")
  FundsWithdrawn = PaymentTransactionClassCodeType.new("FundsWithdrawn")
  MassPay = PaymentTransactionClassCodeType.new("MassPay")
  MoneyRequest = PaymentTransactionClassCodeType.new("MoneyRequest")
  PayPalDebitCard = PaymentTransactionClassCodeType.new("PayPalDebitCard")
  Received = PaymentTransactionClassCodeType.new("Received")
  Referral = PaymentTransactionClassCodeType.new("Referral")
  Refund = PaymentTransactionClassCodeType.new("Refund")
  Reversal = PaymentTransactionClassCodeType.new("Reversal")
  Sent = PaymentTransactionClassCodeType.new("Sent")
  Shipping = PaymentTransactionClassCodeType.new("Shipping")
  Subscription = PaymentTransactionClassCodeType.new("Subscription")
end

# {urn:ebay:apis:eBLBaseComponents}MatchStatusCodeType
class MatchStatusCodeType < ::String
  @@schema_type = "MatchStatusCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Matched = MatchStatusCodeType.new("Matched")
  None = MatchStatusCodeType.new("None")
  Unmatched = MatchStatusCodeType.new("Unmatched")
end

# {urn:ebay:apis:eBLBaseComponents}CompleteCodeType
class CompleteCodeType < ::String
  @@schema_type = "CompleteCodeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Complete = CompleteCodeType.new("Complete")
  NotComplete = CompleteCodeType.new("NotComplete")
end

# {urn:ebay:apis:eBLBaseComponents}TransactionEntityType
class TransactionEntityType < ::String
  @@schema_type = "TransactionEntityType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Auth = TransactionEntityType.new("Auth")
  None = TransactionEntityType.new("None")
  Order = TransactionEntityType.new("Order")
  Payment = TransactionEntityType.new("Payment")
  Reauth = TransactionEntityType.new("Reauth")
end

# {urn:ebay:apis:eBLBaseComponents}MarketingCategoryType
class MarketingCategoryType < ::String
  @@schema_type = "MarketingCategoryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  MarketingCategory1 = MarketingCategoryType.new("Marketing-Category1")
  MarketingCategory2 = MarketingCategoryType.new("Marketing-Category2")
end

# {urn:ebay:apis:eBLBaseComponents}BusinessTypeType
class BusinessTypeType < ::String
  @@schema_type = "BusinessTypeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Corporation = BusinessTypeType.new("Corporation")
  Government = BusinessTypeType.new("Government")
  Individual = BusinessTypeType.new("Individual")
  Nonprofit = BusinessTypeType.new("Nonprofit")
  Partnership = BusinessTypeType.new("Partnership")
  Proprietorship = BusinessTypeType.new("Proprietorship")
  Unknown = BusinessTypeType.new("Unknown")
end

# {urn:ebay:apis:eBLBaseComponents}BusinessCategoryType
class BusinessCategoryType < ::String
  @@schema_type = "BusinessCategoryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Antiques = BusinessCategoryType.new("Antiques")
  Arts = BusinessCategoryType.new("Arts")
  Automotive = BusinessCategoryType.new("Automotive")
  Beauty = BusinessCategoryType.new("Beauty")
  Books = BusinessCategoryType.new("Books")
  Business = BusinessCategoryType.new("Business")
  CamerasAndPhotography = BusinessCategoryType.new("Cameras-and-Photography")
  CategoryUnspecified = BusinessCategoryType.new("Category-Unspecified")
  Clothing = BusinessCategoryType.new("Clothing")
  Collectibles = BusinessCategoryType.new("Collectibles")
  ComputerHardwareAndSoftware = BusinessCategoryType.new("Computer-Hardware-and-Software")
  CultureAndReligion = BusinessCategoryType.new("Culture-and-Religion")
  ElectronicsAndTelecom = BusinessCategoryType.new("Electronics-and-Telecom")
  Entertainment = BusinessCategoryType.new("Entertainment")
  EntertainmentMemorabilia = BusinessCategoryType.new("Entertainment-Memorabilia")
  FoodDrinkAndNutrition = BusinessCategoryType.new("Food-Drink-and-Nutrition")
  GiftsAndFlowers = BusinessCategoryType.new("Gifts-and-Flowers")
  HobbiesToysAndGames = BusinessCategoryType.new("Hobbies-Toys-and-Games")
  HomeAndGarden = BusinessCategoryType.new("Home-and-Garden")
  InternetAndNetworkServices = BusinessCategoryType.new("Internet-and-Network-Services")
  MediaAndEntertainment = BusinessCategoryType.new("Media-and-Entertainment")
  MedicalAndPharmaceutical = BusinessCategoryType.new("Medical-and-Pharmaceutical")
  MoneyServiceBusinesses = BusinessCategoryType.new("Money-Service-Businesses")
  NonProfitPoliticalAndReligion = BusinessCategoryType.new("Non-Profit-Political-and-Religion")
  NotElsewhereClassified = BusinessCategoryType.new("Not-Elsewhere-Classified")
  OtherCategories = BusinessCategoryType.new("Other-Categories")
  PetsAndAnimals = BusinessCategoryType.new("Pets-and-Animals")
  RealEstate = BusinessCategoryType.new("Real-Estate")
  Services = BusinessCategoryType.new("Services")
  SportsAndRecreation = BusinessCategoryType.new("Sports-and-Recreation")
  Travel = BusinessCategoryType.new("Travel")
end

# {urn:ebay:apis:eBLBaseComponents}BusinessSubCategoryType
class BusinessSubCategoryType < ::String
  @@schema_type = "BusinessSubCategoryType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  ANTIQUESAntiquities = BusinessSubCategoryType.new("ANTIQUES-Antiquities")
  ANTIQUESArtifactsGraveRelatedAndNativeAmericanCrafts = BusinessSubCategoryType.new("ANTIQUES-Artifacts-Grave-related-and-Native-American-Crafts")
  ANTIQUESBooksManuscripts = BusinessSubCategoryType.new("ANTIQUES-Books-Manuscripts")
  ANTIQUESCultural = BusinessSubCategoryType.new("ANTIQUES-Cultural")
  ANTIQUESDecorative = BusinessSubCategoryType.new("ANTIQUES-Decorative")
  ANTIQUESFurniture = BusinessSubCategoryType.new("ANTIQUES-Furniture")
  ANTIQUESGeneral = BusinessSubCategoryType.new("ANTIQUES-General")
  ANTIQUESGlass = BusinessSubCategoryType.new("ANTIQUES-Glass")
  ANTIQUESPottery = BusinessSubCategoryType.new("ANTIQUES-Pottery")
  ANTIQUESRugsCarpets = BusinessSubCategoryType.new("ANTIQUES-RugsCarpets")
  ARTSANDCRAFTSArtAndCraftSupplies = BusinessSubCategoryType.new("ARTSANDCRAFTS-Art-and-Craft-Supplies")
  ARTSANDCRAFTSArtDealerAndGalleries = BusinessSubCategoryType.new("ARTSANDCRAFTS-Art-Dealer-and-Galleries")
  ARTSANDCRAFTSFabricsAndSewing = BusinessSubCategoryType.new("ARTSANDCRAFTS-Fabrics-and-Sewing")
  ARTSANDCRAFTSGeneral = BusinessSubCategoryType.new("ARTSANDCRAFTS-General")
  ARTSANDCRAFTSPainting = BusinessSubCategoryType.new("ARTSANDCRAFTS-Painting")
  ARTSANDCRAFTSPhotography = BusinessSubCategoryType.new("ARTSANDCRAFTS-Photography")
  ARTSANDCRAFTSPrints = BusinessSubCategoryType.new("ARTSANDCRAFTS-Prints")
  ARTSANDCRAFTSQuilting = BusinessSubCategoryType.new("ARTSANDCRAFTS-Quilting")
  ARTSANDCRAFTSReproductions = BusinessSubCategoryType.new("ARTSANDCRAFTS-Reproductions")
  ARTSANDCRAFTSScrapbooking = BusinessSubCategoryType.new("ARTSANDCRAFTS-Scrapbooking")
  ARTSANDCRAFTSSculptures = BusinessSubCategoryType.new("ARTSANDCRAFTS-Sculptures")
  ARTSANDCRAFTSWoodworking = BusinessSubCategoryType.new("ARTSANDCRAFTS-Woodworking")
  AUTOMOTIVEAutos = BusinessSubCategoryType.new("AUTOMOTIVE-Autos")
  AUTOMOTIVEAviation = BusinessSubCategoryType.new("AUTOMOTIVE-Aviation")
  AUTOMOTIVEGeneral = BusinessSubCategoryType.new("AUTOMOTIVE-General")
  AUTOMOTIVEMotorcycles = BusinessSubCategoryType.new("AUTOMOTIVE-Motorcycles")
  AUTOMOTIVEPartsAndSupplies = BusinessSubCategoryType.new("AUTOMOTIVE-Parts-and-Supplies")
  AUTOMOTIVEServices = BusinessSubCategoryType.new("AUTOMOTIVE-Services")
  AUTOMOTIVEVintageAndCollectibleVehicles = BusinessSubCategoryType.new("AUTOMOTIVE-Vintage-and-Collectible-Vehicles")
  BEAUTYBodyCarePersonalHygiene = BusinessSubCategoryType.new("BEAUTY-Body-Care-Personal-Hygiene")
  BEAUTYFragrancesAndPerfumes = BusinessSubCategoryType.new("BEAUTY-Fragrances-and-Perfumes")
  BEAUTYGeneral = BusinessSubCategoryType.new("BEAUTY-General")
  BEAUTYMakeup = BusinessSubCategoryType.new("BEAUTY-Makeup")
  BOOKSAudioBooks = BusinessSubCategoryType.new("BOOKS-Audio-Books")
  BOOKSChildrenBooks = BusinessSubCategoryType.new("BOOKS-Children-Books")
  BOOKSComputerBooks = BusinessSubCategoryType.new("BOOKS-Computer-Books")
  BOOKSEducationalAndTextbooks = BusinessSubCategoryType.new("BOOKS-Educational-and-Textbooks")
  BOOKSFictionAndLiterature = BusinessSubCategoryType.new("BOOKS-Fiction-and-Literature")
  BOOKSGeneral = BusinessSubCategoryType.new("BOOKS-General")
  BOOKSMagazines = BusinessSubCategoryType.new("BOOKS-Magazines")
  BOOKSNonFiction = BusinessSubCategoryType.new("BOOKS-NonFiction")
  BOOKSVintageAndCollectibles = BusinessSubCategoryType.new("BOOKS-Vintage-and-Collectibles")
  BUSINESSAdvertising = BusinessSubCategoryType.new("BUSINESS-Advertising")
  BUSINESSAgricultural = BusinessSubCategoryType.new("BUSINESS-Agricultural")
  BUSINESSConstruction = BusinessSubCategoryType.new("BUSINESS-Construction")
  BUSINESSEducational = BusinessSubCategoryType.new("BUSINESS-Educational")
  BUSINESSEmployment = BusinessSubCategoryType.new("BUSINESS-Employment")
  BUSINESSGeneral = BusinessSubCategoryType.new("BUSINESS-General")
  BUSINESSGeneralServices = BusinessSubCategoryType.new("BUSINESS-GeneralServices")
  BUSINESSIndustrial = BusinessSubCategoryType.new("BUSINESS-Industrial")
  BUSINESSIndustrialSolvents = BusinessSubCategoryType.new("BUSINESS-Industrial-Solvents")
  BUSINESSMarketing = BusinessSubCategoryType.new("BUSINESS-Marketing")
  BUSINESSMeetingPlanners = BusinessSubCategoryType.new("BUSINESS-Meeting-Planners")
  BUSINESSMessagingAndPagingServices = BusinessSubCategoryType.new("BUSINESS-Messaging-and-Paging-Services")
  BUSINESSOfficeSuppliesAndEquipment = BusinessSubCategoryType.new("BUSINESS-Office-Supplies-and-Equipment")
  BUSINESSPublishing = BusinessSubCategoryType.new("BUSINESS-Publishing")
  BUSINESSSeminars = BusinessSubCategoryType.new("BUSINESS-Seminars")
  BUSINESSShippingAndPackaging = BusinessSubCategoryType.new("BUSINESS-Shipping-and-Packaging")
  BUSINESSWholesale = BusinessSubCategoryType.new("BUSINESS-Wholesale")
  CAMERASANDPHOTOGRAPHYAccessories = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-Accessories")
  CAMERASANDPHOTOGRAPHYCameras = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-Cameras")
  CAMERASANDPHOTOGRAPHYFilm = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-Film")
  CAMERASANDPHOTOGRAPHYGeneral = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-General")
  CAMERASANDPHOTOGRAPHYSupplies = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-Supplies")
  CAMERASANDPHOTOGRAPHYVideoEquipment = BusinessSubCategoryType.new("CAMERASANDPHOTOGRAPHY-Video-Equipment")
  CLOTHINGAccessories = BusinessSubCategoryType.new("CLOTHING-Accessories")
  CLOTHINGBabiesClothingAndSupplies = BusinessSubCategoryType.new("CLOTHING-Babies-Clothing-and-Supplies")
  CLOTHINGChildrensClothing = BusinessSubCategoryType.new("CLOTHING-Childrens-Clothing")
  CLOTHINGGeneral = BusinessSubCategoryType.new("CLOTHING-General")
  CLOTHINGJewelry = BusinessSubCategoryType.new("CLOTHING-Jewelry")
  CLOTHINGMensClothing = BusinessSubCategoryType.new("CLOTHING-Mens-Clothing")
  CLOTHINGRings = BusinessSubCategoryType.new("CLOTHING-Rings")
  CLOTHINGShoes = BusinessSubCategoryType.new("CLOTHING-Shoes")
  CLOTHINGWatchesAndClocks = BusinessSubCategoryType.new("CLOTHING-Watches-and-Clocks")
  CLOTHINGWeddingClothing = BusinessSubCategoryType.new("CLOTHING-Wedding-Clothing")
  CLOTHINGWomensClothing = BusinessSubCategoryType.new("CLOTHING-Womens-Clothing")
  COLLECTIBLESAdvertising = BusinessSubCategoryType.new("COLLECTIBLES-Advertising")
  COLLECTIBLESAnimals = BusinessSubCategoryType.new("COLLECTIBLES-Animals")
  COLLECTIBLESAnimation = BusinessSubCategoryType.new("COLLECTIBLES-Animation")
  COLLECTIBLESCoinOperatedBanksAndCasinos = BusinessSubCategoryType.new("COLLECTIBLES-Coin-Operated-Banks-and-Casinos")
  COLLECTIBLESCoinsAndPaperMoney = BusinessSubCategoryType.new("COLLECTIBLES-Coins-and-Paper-Money")
  COLLECTIBLESComics = BusinessSubCategoryType.new("COLLECTIBLES-Comics")
  COLLECTIBLESDecorative = BusinessSubCategoryType.new("COLLECTIBLES-Decorative")
  COLLECTIBLESDisneyana = BusinessSubCategoryType.new("COLLECTIBLES-Disneyana")
  COLLECTIBLESGeneral = BusinessSubCategoryType.new("COLLECTIBLES-General")
  COLLECTIBLESHoliday = BusinessSubCategoryType.new("COLLECTIBLES-Holiday")
  COLLECTIBLESKnivesAndSwords = BusinessSubCategoryType.new("COLLECTIBLES-Knives-and-Swords")
  COLLECTIBLESMilitaria = BusinessSubCategoryType.new("COLLECTIBLES-Militaria")
  COLLECTIBLESPostcardsAndPaper = BusinessSubCategoryType.new("COLLECTIBLES-Postcards-and-Paper")
  COLLECTIBLESStamps = BusinessSubCategoryType.new("COLLECTIBLES-Stamps")
  COMPUTERHARDWAREANDSOFTWAREAcademicSoftware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Academic-Software")
  COMPUTERHARDWAREANDSOFTWAREBetaSoftware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Beta-Software")
  COMPUTERHARDWAREANDSOFTWAREDesktopPCs = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Desktop-PCs")
  COMPUTERHARDWAREANDSOFTWAREGameSoftware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Game-Software")
  COMPUTERHARDWAREANDSOFTWAREGeneral = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-General")
  COMPUTERHARDWAREANDSOFTWAREGeneralSoftware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-GeneralSoftware")
  COMPUTERHARDWAREANDSOFTWAREHardware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Hardware")
  COMPUTERHARDWAREANDSOFTWARELaptopsNotebooksPDAs = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Laptops-Notebooks-PDAs")
  COMPUTERHARDWAREANDSOFTWAREMonitors = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Monitors")
  COMPUTERHARDWAREANDSOFTWARENetworkingEquipment = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Networking-Equipment")
  COMPUTERHARDWAREANDSOFTWAREOemSoftware = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Oem-Software")
  COMPUTERHARDWAREANDSOFTWAREPartsAndAccessories = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Parts-and-Accessories")
  COMPUTERHARDWAREANDSOFTWAREPeripherals = BusinessSubCategoryType.new("COMPUTERHARDWAREANDSOFTWARE-Peripherals")
  CULTUREANDRELIGIONChristianity = BusinessSubCategoryType.new("CULTUREANDRELIGION-Christianity")
  CULTUREANDRELIGIONCollectibles = BusinessSubCategoryType.new("CULTUREANDRELIGION-Collectibles")
  CULTUREANDRELIGIONGeneral = BusinessSubCategoryType.new("CULTUREANDRELIGION-General")
  CULTUREANDRELIGIONMetaphysical = BusinessSubCategoryType.new("CULTUREANDRELIGION-Metaphysical")
  CULTUREANDRELIGIONNewAge = BusinessSubCategoryType.new("CULTUREANDRELIGION-New-Age")
  CULTUREANDRELIGIONOrganizations = BusinessSubCategoryType.new("CULTUREANDRELIGION-Organizations")
  CULTUREANDRELIGIONOtherFaiths = BusinessSubCategoryType.new("CULTUREANDRELIGION-Other-Faiths")
  ELECTRONICSANDTELECOMBatteries = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Batteries")
  ELECTRONICSANDTELECOMCarAudioAndElectronics = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Car-Audio-and-Electronics")
  ELECTRONICSANDTELECOMCellPhonesAndPagers = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Cell-Phones-and-Pagers")
  ELECTRONICSANDTELECOMGadgetsAndOtherElectronics = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Gadgets-and-other-electronics")
  ELECTRONICSANDTELECOMGeneralElectronics = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-GeneralElectronics")
  ELECTRONICSANDTELECOMGeneralTelecom = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-GeneralTelecom")
  ELECTRONICSANDTELECOMHomeAudio = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Home-Audio")
  ELECTRONICSANDTELECOMHomeElectronics = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Home-Electronics")
  ELECTRONICSANDTELECOMRadarDectors = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Radar-Dectors")
  ELECTRONICSANDTELECOMRadarJammingDevices = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Radar-Jamming-Devices")
  ELECTRONICSANDTELECOMSatelliteAndCableTVDescramblers = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Satellite-and-Cable-TV-Descramblers")
  ELECTRONICSANDTELECOMScannersRadios = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-ScannersRadios")
  ELECTRONICSANDTELECOMSurveillanceEquipment = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Surveillance-Equipment")
  ELECTRONICSANDTELECOMTelephoneCards = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Telephone-Cards")
  ELECTRONICSANDTELECOMTelephoneEquipment = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Telephone-Equipment")
  ELECTRONICSANDTELECOMTelephoneServices = BusinessSubCategoryType.new("ELECTRONICSANDTELECOM-Telephone-Services")
  ENTERTAINMENTBootlegRecordings = BusinessSubCategoryType.new("ENTERTAINMENT-Bootleg-Recordings")
  ENTERTAINMENTConcerts = BusinessSubCategoryType.new("ENTERTAINMENT-Concerts")
  ENTERTAINMENTGeneral = BusinessSubCategoryType.new("ENTERTAINMENT-General")
  ENTERTAINMENTMEMORABILIAAutographs = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Autographs")
  ENTERTAINMENTMEMORABILIAGeneral = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-General")
  ENTERTAINMENTMEMORABILIALimitedEditions = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Limited-Editions")
  ENTERTAINMENTMEMORABILIAMovie = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Movie")
  ENTERTAINMENTMEMORABILIAMusic = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Music")
  ENTERTAINMENTMEMORABILIANovelties = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Novelties")
  ENTERTAINMENTMEMORABILIAPhotos = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Photos")
  ENTERTAINMENTMEMORABILIAPosters = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Posters")
  ENTERTAINMENTMEMORABILIAScienceFiction = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Science-Fiction")
  ENTERTAINMENTMEMORABILIASportsAndFanShop = BusinessSubCategoryType.new("ENTERTAINMENTMEMORABILIA-Sports-and-Fan-Shop")
  ENTERTAINMENTMovies = BusinessSubCategoryType.new("ENTERTAINMENT-Movies")
  ENTERTAINMENTMusic = BusinessSubCategoryType.new("ENTERTAINMENT-Music")
  ENTERTAINMENTPromotionalItems = BusinessSubCategoryType.new("ENTERTAINMENT-Promotional-Items")
  ENTERTAINMENTTheater = BusinessSubCategoryType.new("ENTERTAINMENT-Theater")
  FOODDRINKANDNUTRITIONAlcoholicBeverages = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Alcoholic-Beverages")
  FOODDRINKANDNUTRITIONCoffeeAndTea = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Coffee-and-Tea")
  FOODDRINKANDNUTRITIONFoodProducts = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Food-Products")
  FOODDRINKANDNUTRITIONGeneral = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-General")
  FOODDRINKANDNUTRITIONGourmetItems = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Gourmet-Items")
  FOODDRINKANDNUTRITIONHealthAndNutrition = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Health-and-Nutrition")
  FOODDRINKANDNUTRITIONRestaurant = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Restaurant")
  FOODDRINKANDNUTRITIONServices = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Services")
  FOODDRINKANDNUTRITIONTobaccoAndCigars = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Tobacco-and-Cigars")
  FOODDRINKANDNUTRITIONVitaminsAndSupplements = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Vitamins-and-Supplements")
  FOODDRINKANDNUTRITIONWeightManagementAndHealthProducts = BusinessSubCategoryType.new("FOODDRINKANDNUTRITION-Weight-Management-and-Health-Products")
  GIFTSANDFLOWERSFlowers = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Flowers")
  GIFTSANDFLOWERSGeneral = BusinessSubCategoryType.new("GIFTSANDFLOWERS-General")
  GIFTSANDFLOWERSGreetingCards = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Greeting-Cards")
  GIFTSANDFLOWERSHumorousGiftsAndNovelties = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Humorous-Gifts-and-Novelties")
  GIFTSANDFLOWERSPersonalizedGifts = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Personalized-Gifts")
  GIFTSANDFLOWERSProducts = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Products")
  GIFTSANDFLOWERSServices = BusinessSubCategoryType.new("GIFTSANDFLOWERS-Services")
  HOBBIESTOYSANDGAMESActionFigures = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Action-Figures")
  HOBBIESTOYSANDGAMESBackupUnreleasedGames = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-BackupUnreleased-Games")
  HOBBIESTOYSANDGAMESBarbies = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Barbies")
  HOBBIESTOYSANDGAMESBeanBabies = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Bean-Babies")
  HOBBIESTOYSANDGAMESBears = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Bears")
  HOBBIESTOYSANDGAMESDiecastToysVehicles = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Diecast-Toys-Vehicles")
  HOBBIESTOYSANDGAMESDolls = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Dolls")
  HOBBIESTOYSANDGAMESGameCopyingHardwaresoftware = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Game-copying-hardwaresoftware")
  HOBBIESTOYSANDGAMESGames = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Games")
  HOBBIESTOYSANDGAMESGeneral = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-General")
  HOBBIESTOYSANDGAMESModChips = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Mod-Chips")
  HOBBIESTOYSANDGAMESModelKits = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Model-Kits")
  HOBBIESTOYSANDGAMESVideoGamesAndSystems = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Video-Games-and-Systems")
  HOBBIESTOYSANDGAMESVintageAndAntiqueToys = BusinessSubCategoryType.new("HOBBIESTOYSANDGAMES-Vintage-and-Antique-Toys")
  HOMEANDGARDENAppliances = BusinessSubCategoryType.new("HOMEANDGARDEN-Appliances")
  HOMEANDGARDENBedAndBath = BusinessSubCategoryType.new("HOMEANDGARDEN-Bed-and-Bath")
  HOMEANDGARDENFurnishingAndDecorating = BusinessSubCategoryType.new("HOMEANDGARDEN-Furnishing-and-Decorating")
  HOMEANDGARDENGardenSupplies = BusinessSubCategoryType.new("HOMEANDGARDEN-Garden-Supplies")
  HOMEANDGARDENGeneral = BusinessSubCategoryType.new("HOMEANDGARDEN-General")
  HOMEANDGARDENHardwareAndTools = BusinessSubCategoryType.new("HOMEANDGARDEN-Hardware-and-Tools")
  HOMEANDGARDENHouseholdGoods = BusinessSubCategoryType.new("HOMEANDGARDEN-Household-Goods")
  HOMEANDGARDENKitchenware = BusinessSubCategoryType.new("HOMEANDGARDEN-Kitchenware")
  HOMEANDGARDENPlantsAndSeeds = BusinessSubCategoryType.new("HOMEANDGARDEN-Plants-and-Seeds")
  HOMEANDGARDENRugsAndCarpets = BusinessSubCategoryType.new("HOMEANDGARDEN-Rugs-and-Carpets")
  HOMEANDGARDENSecurityAndHomeDefense = BusinessSubCategoryType.new("HOMEANDGARDEN-Security-and-Home-Defense")
  INTERNETANDNETWORKSERVICESAuctionManagementTools = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-Auction-management-tools")
  INTERNETANDNETWORKSERVICESBulletinBoard = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-Bulletin-board")
  INTERNETANDNETWORKSERVICESEcommerceDevelopment = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-ecommerce-development")
  INTERNETANDNETWORKSERVICESGeneral = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-General")
  INTERNETANDNETWORKSERVICESOnlineMalls = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-Online-Malls")
  INTERNETANDNETWORKSERVICESOnlineServices = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-online-services")
  INTERNETANDNETWORKSERVICESTrainingServices = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-training-services")
  INTERNETANDNETWORKSERVICESWebHostingAndDesign = BusinessSubCategoryType.new("INTERNETANDNETWORKSERVICES-Web-hosting-and-design")
  MEDIAANDENTERTAINMENTConcerts = BusinessSubCategoryType.new("MEDIAANDENTERTAINMENT-Concerts")
  MEDIAANDENTERTAINMENTGeneral = BusinessSubCategoryType.new("MEDIAANDENTERTAINMENT-General")
  MEDIAANDENTERTAINMENTTheater = BusinessSubCategoryType.new("MEDIAANDENTERTAINMENT-Theater")
  MEDICALANDPHARMACEUTICALDental = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-Dental")
  MEDICALANDPHARMACEUTICALDevices = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-Devices")
  MEDICALANDPHARMACEUTICALGeneral = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-General")
  MEDICALANDPHARMACEUTICALMedical = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-Medical")
  MEDICALANDPHARMACEUTICALOpthamalic = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-Opthamalic")
  MEDICALANDPHARMACEUTICALPrescriptionDrugs = BusinessSubCategoryType.new("MEDICALANDPHARMACEUTICAL-Prescription-Drugs")
  MONEYSERVICEBUSINESSESCheckCashier = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Check-Cashier")
  MONEYSERVICEBUSINESSESCurrencyDealerExchange = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Currency-DealerExchange")
  MONEYSERVICEBUSINESSESElectronicCash = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Electronic-Cash")
  MONEYSERVICEBUSINESSESGeneral = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-General")
  MONEYSERVICEBUSINESSESMoneyOrders = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Money-Orders")
  MONEYSERVICEBUSINESSESRemittance = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Remittance")
  MONEYSERVICEBUSINESSESStoredValueCards = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Stored-Value-Cards")
  MONEYSERVICEBUSINESSESTravelersChecks = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Travelers-Checks")
  MONEYSERVICEBUSINESSESWireTransfer = BusinessSubCategoryType.new("MONEYSERVICEBUSINESSES-Wire-Transfer")
  NONPROFITPOLITICALANDRELIGIONCharities = BusinessSubCategoryType.new("NONPROFITPOLITICALANDRELIGION-Charities")
  NONPROFITPOLITICALANDRELIGIONGeneral = BusinessSubCategoryType.new("NONPROFITPOLITICALANDRELIGION-General")
  NONPROFITPOLITICALANDRELIGIONPolitical = BusinessSubCategoryType.new("NONPROFITPOLITICALANDRELIGION-Political")
  NONPROFITPOLITICALANDRELIGIONReligious = BusinessSubCategoryType.new("NONPROFITPOLITICALANDRELIGION-Religious")
  OtherSubCategories = BusinessSubCategoryType.new("Other-SubCategories")
  PETSANDANIMALSGeneral = BusinessSubCategoryType.new("PETSANDANIMALS-General")
  PETSANDANIMALSSuppliesAndToys = BusinessSubCategoryType.new("PETSANDANIMALS-Supplies-and-Toys")
  PETSANDANIMALSWildlifeProducts = BusinessSubCategoryType.new("PETSANDANIMALS-Wildlife-Products")
  REALESTATECommercial = BusinessSubCategoryType.new("REALESTATE-Commercial")
  REALESTATEGeneral = BusinessSubCategoryType.new("REALESTATE-General")
  REALESTATEResidential = BusinessSubCategoryType.new("REALESTATE-Residential")
  REALESTATETimeShares = BusinessSubCategoryType.new("REALESTATE-Time-Shares")
  SERVICESAggregators = BusinessSubCategoryType.new("SERVICES-Aggregators")
  SERVICESChildCareServices = BusinessSubCategoryType.new("SERVICES-Child-Care-Services")
  SERVICESConsulting = BusinessSubCategoryType.new("SERVICES-Consulting")
  SERVICESDental = BusinessSubCategoryType.new("SERVICES-Dental")
  SERVICESEntertainment = BusinessSubCategoryType.new("SERVICES-Entertainment")
  SERVICESEventAndWeddingPlanning = BusinessSubCategoryType.new("SERVICES-Event-and-Wedding-Planning")
  SERVICESFinancialServices = BusinessSubCategoryType.new("SERVICES-Financial-Services")
  SERVICESGeneral = BusinessSubCategoryType.new("SERVICES-General")
  SERVICESGeneralGovernment = BusinessSubCategoryType.new("SERVICES-GeneralGovernment")
  SERVICESGraphicAndCommercialDesign = BusinessSubCategoryType.new("SERVICES-Graphic-and-Commercial-Design")
  SERVICESImportingExporting = BusinessSubCategoryType.new("SERVICES-ImportingExporting")
  SERVICESInsuranceDirect = BusinessSubCategoryType.new("SERVICES-InsuranceDirect")
  SERVICESLandscaping = BusinessSubCategoryType.new("SERVICES-Landscaping")
  SERVICESLegal = BusinessSubCategoryType.new("SERVICES-Legal")
  SERVICESLocksmith = BusinessSubCategoryType.new("SERVICES-Locksmith")
  SERVICESMedical = BusinessSubCategoryType.new("SERVICES-Medical")
  SERVICESOnlineDating = BusinessSubCategoryType.new("SERVICES-Online-Dating")
  SERVICESSchoolsAndColleges = BusinessSubCategoryType.new("SERVICES-Schools-and-Colleges")
  SERVICESVision = BusinessSubCategoryType.new("SERVICES-Vision")
  SPORTSANDRECREATIONBicyclesAndAccessories = BusinessSubCategoryType.new("SPORTSANDRECREATION-Bicycles-and-Accessories")
  SPORTSANDRECREATIONBoatingSailingAndAccessories = BusinessSubCategoryType.new("SPORTSANDRECREATION-Boating-Sailing-and-Accessories")
  SPORTSANDRECREATIONCampingAndSurvival = BusinessSubCategoryType.new("SPORTSANDRECREATION-Camping-and-Survival")
  SPORTSANDRECREATIONExerciseEquipment = BusinessSubCategoryType.new("SPORTSANDRECREATION-Exercise-Equipment")
  SPORTSANDRECREATIONFishing = BusinessSubCategoryType.new("SPORTSANDRECREATION-Fishing")
  SPORTSANDRECREATIONGeneral = BusinessSubCategoryType.new("SPORTSANDRECREATION-General")
  SPORTSANDRECREATIONGolf = BusinessSubCategoryType.new("SPORTSANDRECREATION-Golf")
  SPORTSANDRECREATIONHunting = BusinessSubCategoryType.new("SPORTSANDRECREATION-Hunting")
  SPORTSANDRECREATIONPaintball = BusinessSubCategoryType.new("SPORTSANDRECREATION-Paintball")
  SPORTSANDRECREATIONSportingGoods = BusinessSubCategoryType.new("SPORTSANDRECREATION-Sporting-Goods")
  SPORTSANDRECREATIONSwimmingPoolsAndSpas = BusinessSubCategoryType.new("SPORTSANDRECREATION-Swimming-Pools-and-Spas")
  SubCategoryUnspecified = BusinessSubCategoryType.new("SubCategory-Unspecified")
  TRAVELAccommodations = BusinessSubCategoryType.new("TRAVEL-Accommodations")
  TRAVELAgencies = BusinessSubCategoryType.new("TRAVEL-Agencies")
  TRAVELAirlines = BusinessSubCategoryType.new("TRAVEL-Airlines")
  TRAVELAirlinesSpiritAir = BusinessSubCategoryType.new("TRAVEL-AirlinesSpirit-Air")
  TRAVELAutoRentals = BusinessSubCategoryType.new("TRAVEL-Auto-Rentals")
  TRAVELCruises = BusinessSubCategoryType.new("TRAVEL-Cruises")
  TRAVELGeneral = BusinessSubCategoryType.new("TRAVEL-General")
  TRAVELOtherTransportation = BusinessSubCategoryType.new("TRAVEL-Other-Transportation")
  TRAVELServices = BusinessSubCategoryType.new("TRAVEL-Services")
  TRAVELSupplies = BusinessSubCategoryType.new("TRAVEL-Supplies")
  TRAVELTours = BusinessSubCategoryType.new("TRAVEL-Tours")
end

# {urn:ebay:apis:eBLBaseComponents}AverageTransactionPriceType
class AverageTransactionPriceType < ::String
  @@schema_type = "AverageTransactionPriceType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AverageTransactionPriceNotApplicable = AverageTransactionPriceType.new("AverageTransactionPrice-Not-Applicable")
  AverageTransactionPriceRange1 = AverageTransactionPriceType.new("AverageTransactionPrice-Range1")
  AverageTransactionPriceRange10 = AverageTransactionPriceType.new("AverageTransactionPrice-Range10")
  AverageTransactionPriceRange2 = AverageTransactionPriceType.new("AverageTransactionPrice-Range2")
  AverageTransactionPriceRange3 = AverageTransactionPriceType.new("AverageTransactionPrice-Range3")
  AverageTransactionPriceRange4 = AverageTransactionPriceType.new("AverageTransactionPrice-Range4")
  AverageTransactionPriceRange5 = AverageTransactionPriceType.new("AverageTransactionPrice-Range5")
  AverageTransactionPriceRange6 = AverageTransactionPriceType.new("AverageTransactionPrice-Range6")
  AverageTransactionPriceRange7 = AverageTransactionPriceType.new("AverageTransactionPrice-Range7")
  AverageTransactionPriceRange8 = AverageTransactionPriceType.new("AverageTransactionPrice-Range8")
  AverageTransactionPriceRange9 = AverageTransactionPriceType.new("AverageTransactionPrice-Range9")
end

# {urn:ebay:apis:eBLBaseComponents}AverageMonthlyVolumeType
class AverageMonthlyVolumeType < ::String
  @@schema_type = "AverageMonthlyVolumeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AverageMonthlyVolumeNotApplicable = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Not-Applicable")
  AverageMonthlyVolumeRange1 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range1")
  AverageMonthlyVolumeRange2 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range2")
  AverageMonthlyVolumeRange3 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range3")
  AverageMonthlyVolumeRange4 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range4")
  AverageMonthlyVolumeRange5 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range5")
  AverageMonthlyVolumeRange6 = AverageMonthlyVolumeType.new("AverageMonthlyVolume-Range6")
end

# {urn:ebay:apis:eBLBaseComponents}SalesVenueType
class SalesVenueType < ::String
  @@schema_type = "SalesVenueType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AnotherMarketPlace = SalesVenueType.new("AnotherMarketPlace")
  EBay = SalesVenueType.new("eBay")
  Other = SalesVenueType.new("Other")
  OwnWebsite = SalesVenueType.new("OwnWebsite")
  VenueUnspecified = SalesVenueType.new("Venue-Unspecified")
end

# {urn:ebay:apis:eBLBaseComponents}PercentageRevenueFromOnlineSalesType
class PercentageRevenueFromOnlineSalesType < ::String
  @@schema_type = "PercentageRevenueFromOnlineSalesType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  PercentageRevenueFromOnlineSalesNotApplicable = PercentageRevenueFromOnlineSalesType.new("PercentageRevenueFromOnlineSales-Not-Applicable")
  PercentageRevenueFromOnlineSalesRange1 = PercentageRevenueFromOnlineSalesType.new("PercentageRevenueFromOnlineSales-Range1")
  PercentageRevenueFromOnlineSalesRange2 = PercentageRevenueFromOnlineSalesType.new("PercentageRevenueFromOnlineSales-Range2")
  PercentageRevenueFromOnlineSalesRange3 = PercentageRevenueFromOnlineSalesType.new("PercentageRevenueFromOnlineSales-Range3")
  PercentageRevenueFromOnlineSalesRange4 = PercentageRevenueFromOnlineSalesType.new("PercentageRevenueFromOnlineSales-Range4")
end

# {urn:ebay:apis:eBLBaseComponents}BankAccountTypeType
class BankAccountTypeType < ::String
  @@schema_type = "BankAccountTypeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Checking = BankAccountTypeType.new("Checking")
  Savings = BankAccountTypeType.new("Savings")
end

# {urn:ebay:apis:eBLBaseComponents}BoardingStatusType
class BoardingStatusType < ::String
  @@schema_type = "BoardingStatusType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Cancelled = BoardingStatusType.new("Cancelled")
  Completed = BoardingStatusType.new("Completed")
  Pending = BoardingStatusType.new("Pending")
  Unknown = BoardingStatusType.new("Unknown")
end

# {urn:ebay:apis:eBLBaseComponents}UserWithdrawalLimitTypeType
class UserWithdrawalLimitTypeType < ::String
  @@schema_type = "UserWithdrawalLimitTypeType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  Limited = UserWithdrawalLimitTypeType.new("Limited")
  Unknown = UserWithdrawalLimitTypeType.new("Unknown")
  Unlimited = UserWithdrawalLimitTypeType.new("Unlimited")
end

# {urn:ebay:apis:eBLBaseComponents}APIAuthenticationType
class APIAuthenticationType < ::String
  @@schema_type = "APIAuthenticationType"
  @@schema_ns = "urn:ebay:apis:eBLBaseComponents"

  AuthNone = APIAuthenticationType.new("Auth-None")
  Cert = APIAuthenticationType.new("Cert")
  Sign = APIAuthenticationType.new("Sign")
end
