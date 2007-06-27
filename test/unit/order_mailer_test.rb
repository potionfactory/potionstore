require File.dirname(__FILE__) + '/../test_helper'
require 'order_mailer'

class OrderMailerTest < Test::Unit::TestCase
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = "utf-8"
  
  fixtures :orders
  include ActionMailer::Quoting

  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type "text", "plain", { "charset" => CHARSET }
  end
  
  def test_thankyou    
    @actual = OrderMailer.create_thankyou(orders(:first))
    
    #From: is correct 
    assert_equal(@actual.header['from'].to_s,$STORE_PREFS['purchase_receipt_sender_email'])
    #To: is correct 
   assert_equal(@actual.header['to'].to_s,orders(:first).email)
    
    #Make sure we're polite
    assert(@actual.body.match(/thank you/i))
    
  end

  def test_truth
    assert true
  end

  private
    def read_fixture(action)
      IO.readlines("#{FIXTURES_PATH}/order_mailer/#{action}")
    end

    def encode(subject)
      quoted_printable(subject, CHARSET)
    end
end
