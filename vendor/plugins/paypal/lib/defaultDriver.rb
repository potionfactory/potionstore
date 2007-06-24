require 'default.rb'

require 'soap/rpc/driver'

class PayPalAPIInterface < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://api.sandbox.paypal.com/2.0/"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ nil,
      "refundTransaction",
      [ ["in", "RefundTransactionRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "RefundTransactionReq"], true],
        ["out", "RefundTransactionResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "RefundTransactionResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "getTransactionDetails",
      [ ["in", "GetTransactionDetailsRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetTransactionDetailsReq"], true],
        ["out", "GetTransactionDetailsResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetTransactionDetailsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "billUser",
      [ ["in", "BillUserRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "BillUserReq"], true],
        ["out", "BillUserResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "BillUserResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "transactionSearch",
      [ ["in", "TransactionSearchRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "TransactionSearchReq"], true],
        ["out", "TransactionSearchResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "TransactionSearchResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "massPay",
      [ ["in", "MassPayRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "MassPayReq"], true],
        ["out", "MassPayResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "MassPayResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "billAgreementUpdate",
      [ ["in", "BillAgreementUpdateRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "BillAgreementUpdateReq"], true],
        ["out", "body", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "BAUpdateResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "addressVerify",
      [ ["in", "AddressVerifyRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "AddressVerifyReq"], true],
        ["out", "AddressVerifyResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "AddressVerifyResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "enterBoarding",
      [ ["in", "EnterBoardingRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "EnterBoardingReq"], true],
        ["out", "EnterBoardingResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "EnterBoardingResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "getBoardingDetails",
      [ ["in", "GetBoardingDetailsRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetBoardingDetailsReq"], true],
        ["out", "GetBoardingDetailsResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetBoardingDetailsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

require 'soap/rpc/driver'

class PayPalAPIAAInterface < ::SOAP::RPC::Driver
  DefaultEndpointUrl = "https://api-aa.sandbox.paypal.com/2.0/"
  MappingRegistry = ::SOAP::Mapping::Registry.new

  Methods = [
    [ nil,
      "doExpressCheckoutPayment",
      [ ["in", "DoExpressCheckoutPaymentRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoExpressCheckoutPaymentReq"], true],
        ["out", "DoExpressCheckoutPaymentResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoExpressCheckoutPaymentResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "setExpressCheckout",
      [ ["in", "SetExpressCheckoutRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "SetExpressCheckoutReq"], true],
        ["out", "SetExpressCheckoutResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "SetExpressCheckoutResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "getExpressCheckoutDetails",
      [ ["in", "GetExpressCheckoutDetailsRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetExpressCheckoutDetailsReq"], true],
        ["out", "GetExpressCheckoutDetailsResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "GetExpressCheckoutDetailsResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "doDirectPayment",
      [ ["in", "DoDirectPaymentRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoDirectPaymentReq"], true],
        ["out", "DoDirectPaymentResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoDirectPaymentResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "doCapture",
      [ ["in", "DoCaptureRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoCaptureReq"], true],
        ["out", "DoCaptureResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoCaptureResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "doReauthorization",
      [ ["in", "DoReauthorizationRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoReauthorizationReq"], true],
        ["out", "DoReauthorizationResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoReauthorizationResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "doVoid",
      [ ["in", "DoVoidRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoVoidReq"], true],
        ["out", "DoVoidResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoVoidResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ],
    [ nil,
      "doAuthorization",
      [ ["in", "DoAuthorizationRequest", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoAuthorizationReq"], true],
        ["out", "DoAuthorizationResponse", ["::SOAP::SOAPElement", "urn:ebay:api:PayPalAPI", "DoAuthorizationResponse"], true] ],
      { :request_style =>  :document, :request_use =>  :literal,
        :response_style => :document, :response_use => :literal }
    ]
  ]

  def initialize(endpoint_url = nil)
    endpoint_url ||= DefaultEndpointUrl
    super(endpoint_url, nil)
    self.mapping_registry = MappingRegistry
    init_methods
  end

private

  def init_methods
    Methods.each do |definitions|
      opt = definitions.last
      if opt[:request_style] == :document
        add_document_operation(*definitions)
      else
        add_rpc_operation(*definitions)
        qname = definitions[0]
        name = definitions[2]
        if qname.name != name and qname.name.capitalize == name.capitalize
          ::SOAP::Mapping.define_singleton_method(self, qname.name) do |*arg|
            __send__(name, *arg)
          end
        end
      end
    end
  end
end

