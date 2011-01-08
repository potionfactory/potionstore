require File.dirname(__FILE__) + '/../test_helper'
require 'admin/products_controller'

# Re-raise errors caught by the controller.
class Admin::ProductsController; def rescue_action(e) raise e end; end

class AdminProductsControllerTest < ActiveSupport::TestCase
  fixtures :products

  def setup
    @controller = Admin::ProductsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = products(:first).id
  end

  def test_should_not_allow_unauthorized_access
    get 'index'
    assert_redirected_to 'admin/login'
    assert_equal(session[:intended_url] , '/admin/products')
  end

  def test_should_get_index
    get 'index', {}, {:logged_in => true}
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:products)
  end

  def test_should_show_product
    get :show, {:id => @first_id}, {:logged_in => true}

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:product)
    assert assigns(:product).valid?
  end

  def test_should_get_new
    get :new, {}, {:logged_in => true}

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:product)
  end

  def test_should_create_product
    num_products = Product.count

    post :create, {:product => {:code => "product_new_1", :name => "New Product v1"}}, {:logged_in => true}

    assert_response :redirect
    assert_redirected_to admin_product_url(Product.find(:all).last)

    assert_equal num_products + 1, Product.count
  end

  def test_should_get_edit
    get :edit, {:id => @first_id}, {:logged_in => true}

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:product)
    assert assigns(:product).valid?
  end

  def test_should_update_product
    post :update, {:id => @first_id}, {:logged_in => true}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_should_destroy_product
    assert_nothing_raised {
      Product.find(@first_id)
    }

    LineItem.destroy_all

    post :destroy, {:id => @first_id}, {:logged_in => true}
    assert_response :redirect
    assert_redirected_to :controller => 'admin/products', :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) {
      Product.find(@first_id)
    }
  end
end
