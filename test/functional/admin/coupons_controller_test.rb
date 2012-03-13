require 'test_helper'

class Admin::CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = admin_coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_coupon" do
    assert_difference('Admin::Coupon.count') do
      post :create, admin_coupon: @coupon.attributes
    end

    assert_redirected_to admin_coupon_path(assigns(:admin_coupon))
  end

  test "should show admin_coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update admin_coupon" do
    put :update, id: @coupon, admin_coupon: @coupon.attributes
    assert_redirected_to admin_coupon_path(assigns(:admin_coupon))
  end

  test "should destroy admin_coupon" do
    assert_difference('Admin::Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to admin_coupons_path
  end
end
