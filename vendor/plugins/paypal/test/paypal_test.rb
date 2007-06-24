require File.dirname(__FILE__) + '/test_helper'
class PaypalTest < Test::Unit::TestCase
  def setup
        @valid_params = {
               :firstName => "Byung",
               :lastName => "Kim",
               :ip => "24.126.62.178",
               :amount => "10.00", #   //This value has a maximum of 10,000.00
               :itemName => "Podcast Maker",
               :addressName => "Billing",
               :street1 => "P.O. Box 741327",
               :street2 => "",
               :cityName => "Los Angeles",
               :postalCode =>  "90004",
               :stateOrProvince => "CA",
               :country => "US",
               :creditCardType => "Visa",
               :creditCardNumber => "4760071907631264",
               :cVV2 => "121",
               :expMonth => 11  ,  #//Expiration month in numerical form not string
               :expYear => 2007   #  ///Expiration year in numerical form

       }

        @invalid_params = {
               :firstName => "Byung",
               :lastName => "Kim",
               :ip => "24.126.62.178",
               :amount => "10.00", #   //This value has a maximum of 10,000.00
               :itemName => "Podcast Maker",
               :addressName => "Billing",
               :street1 => "P.O. Box 741327",
               :street2 => "",
               :cityName => "Los Angeles",
               :postalCode =>  "90004",
               :stateOrProvince => "CA",
               :country => "US",
               :creditCardType => "Visa",
               :creditCardNumber => "4478068999371265",
               :cVV2 => "000",
               :expMonth => 7  ,  #//Expiration month in numerical form not string
               :expYear => 2006   #  ///Expiration year in numerical form
       }
  end

  def test_successful_directcharge
	  assert Paypal.directcharge(@valid_params).ack == "Success"
  end
  def test_failed_directcharge
	  assert Paypal.directcharge(@invalid_params).ack == "Failure"
  end
  def test_successful_authorization
	  @result = Paypal.directauth(@valid_params) 
	  assert @result.ack != "Failure"
  end
  def test_failed_authorization
	  assert Paypal.directauth(@invalid_params).ack == "Failure"
  end
  def test_successful_capture
	  @result = Paypal.directauth(@valid_params).transactionID
	  params = {
		  :amount => @valid_params[:amount],
		  :transactionID => @result
	  }
          result = Paypal.capture(params)
	  assert result.ack != "Failure"
  end
  def test_successful_voiding
         @result = Paypal.directauth(@valid_params).transactionID
         params = { 
                  :transactionID => @result }
         result = Paypal.void(params)
         assert result.ack == "Success"
  end
  def test_failed_voiding
         params = { :transactionID => "invalidcode" }
         result = Paypal.void(params)
         assert result.ack == "Failure"
  end
         
end
