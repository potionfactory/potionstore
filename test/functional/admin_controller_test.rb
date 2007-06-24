require File.dirname(__FILE__) + '/../test_helper'
require 'admin_controller'

# Re-raise errors caught by the controller.
class AdminController; def rescue_action(e) raise e end; end

class AdminControllerTest < Test::Unit::TestCase
  fixtures :products

  def setup
    @controller = AdminController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index_with_no_password
    get :index
    assert_response :success
    assert_template 'signin_form'
    assert_equal(session[:intended_action] , 'index')
  end

  def test_signin_with_faulty_password
    post :signin, {:username => 'joeblow', :password => 'totallyfakingit'}
    assert_response :success
    assert_template 'signin_form'
  end

  def test_signin_with_good_password
    post :signin, {
       :username => $STORE_PREFS['admin_username'],
       :password => $STORE_PREFS['admin_password']}
       
    assert_redirected_to :action => nil
  end

  def test_orders
    # anybody else know how I can load data
    # into the session? jph/2006-06-24
    process 'orders', {}, { :logged_in => true }
    assert_response :success
    assert_template 'orders'
    assert_not_nil assigns(:orders)
  end

  def generate_coupons_blank
    process 'generate_coupons', {}, { :logged_in => true }
    assert_response :success
    assert_template 'generate_coupons'
  end
end
