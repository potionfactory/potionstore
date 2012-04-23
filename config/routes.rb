Potionstore::Application.routes.draw do
  match 'store' => 'store/order#index'
  match '' => 'store/order#index'
  
  scope "store" do
    match "order/payment" => "store/order#payment"
    match "order/purchase" => "store/order#purchase"
    match "order/thankyou" => "store/order#thankyou"
    match "order/receipt" => "store/order#receipt"
    
    resources :order, :singular => true, :module => "store"
  end

  namespace :admin do
    resources :products
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