Potionstore::Application.routes.draw do
  match 'store' => 'store/order#new'
  match '' => 'store/order#index'
  
  scope "store" do
    match "order/payment" => "store/order#payment"
    match "order/purchase" => "store/order#purchase"
    match "order/thankyou" => "store/order#thankyou"
    match "order/receipt" => "store/order#receipt"
    match "order/purchase_paypal" => "store/order#purchase_paypal"
    match "order/confirm_paypal" => "store/order#confirm_paypal"
    resources :order, :singular => true, :module => "store"
  end

  namespace :admin do
    resources :products
    resources :coupons
    match 'coupons/:id/:operation' => 'coupons#toggle_state', :constraints => { :operation => /disable|enable/ }, :as => 'disable_coupon'
    match 'coupons/:id/toggle_state_for_all_coupons_with_code/:operation' => 'coupons#toggle_state_for_all_coupons_with_code', :constraints => { :operation => /disable|enable/ }, :as => 'toggle_state_for_all_coupons_with_code'
    #match 'coupons/:id/delete_all' => 'coupons#delete_all_coupons_with_code', :as => 'delete_all_coupons_with_code'
    resources :orders do
      member do
        get :cancel
        get :uncancel
        get :refund
        get :send_emails
      end
    end
  end

  match 'admin/charts/:action' => 'admin/charts#index'
  match 'bugreport/crash' => 'email#crash_report'
  match '/:controller(/:action(/:id))'
end