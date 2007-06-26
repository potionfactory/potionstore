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
    assert_redirected_to 'admin/login'
    assert_equal(session[:intended_url] , '/admin')
  end

  def test_login_with_faulty_password
    post :login, {:username => 'joeblow', :password => 'totallyfakingit'}
    assert_template 'login'
    assert_response :success
  end

  def test_login_with_good_password
    post :login, {
       :username => $STORE_PREFS['admin_username'],
       :password => $STORE_PREFS['admin_password']}
       
    assert_redirected_to :action => 'index'
  end

  def generate_coupons_blank
    process 'generate_coupons', {}, { :logged_in => true }
    assert_response :success
    assert_template 'generate_coupons'
  end
end
