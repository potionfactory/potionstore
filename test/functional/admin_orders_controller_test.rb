require File.dirname(__FILE__) + '/../test_helper'
require 'admin/orders_controller'

# Re-raise errors caught by the controller.
class Admin::OrdersController; def rescue_action(e) raise e end; end

class AdminOrdersControllerTest < Test::Unit::TestCase
  fixtures :orders

  def setup
    @controller = Admin::OrdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = orders(:first).id
  end

  def test_should_not_allow_unauthorized_access
    get 'index'
    assert_redirected_to 'admin/login'
    assert_equal(session[:intended_url] , '/admin/orders')
  end

  def test_should_get_index
    # anybody else know how I can load data
    # into the session? jph/2006-06-24
    # It seems like the only way is through the dict in the 3rd argument of get/post/etc. AK/2006-06-26
    get 'index', {}, {:logged_in => true}
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:orders)
  end

  def test_should_show_order
    get :show, {:id => @first_id}, {:logged_in => true}

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:order)
    assert assigns(:order).valid?
  end

  def test_should_get_new
    get :new, {}, {:logged_in => true}

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:order)
  end

  def test_should_create_order
    num_orders = Order.count

    new_order = orders(:first).attributes
    new_order[:id] = nil

    items = {"1" => "1", "2" => "1"}
    item_prices = {"1" => "12.95", "2" => "24.95"}

    post :create, {:order => new_order, :items => items, :item_prices => item_prices}, {:logged_in => true}

    assert_response :redirect
    assert_redirected_to :controller => 'admin/orders' , :action => 'show'

    assert_equal num_orders + 1, Order.count
  end

  def test_should_get_edit
    get :edit, {:id => @first_id}, {:logged_in => true}

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:order)
    assert assigns(:order).valid?
  end

  def test_should_update_order
    items = {"1" => "1", "2" => "1"}
    item_prices = {"1" => "12.95", "2" => "24.95"}

    order = orders(:first).attributes

    post :update, {:order => order, :items => items, :item_prices => item_prices}, {:logged_in => true}

    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

end
