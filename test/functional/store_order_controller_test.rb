require File.dirname(__FILE__) + '/../test_helper'
require 'store/order_controller'

# Re-raise errors caught by the controller.
class Store::OrderController; def rescue_action(e) raise e end; end

class StoreOrderControllerTest < Test::Unit::TestCase

  def setup
    @controller = Store::OrderController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_get_index
    get :index
    assert_response :success
  end

end
