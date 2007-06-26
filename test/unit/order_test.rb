require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < Test::Unit::TestCase
  fixtures :orders
  
  def setup
    @order = Order.find(1)
  end
  
  def test_status_description
    @dummy = Order.new
    {"P" => "Pending",
     "C" => "Complete",
     "F" => "Failed",
     "X" => "Cancelled"}.each do |abbrev, description|
      @dummy.status = abbrev
    assert_equal(@dummy.status_description , description)
    end
  end
  
  def test_create_order
    
    
  end
  
end
