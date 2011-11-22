Potionstore::Application.routes.draw do
  match 'store' => 'store/order#index'
  match '' => 'store/order#index'
  resource :order
  resources :products
  resources :orders do
  
    member do
  get :cancel
  get :uncancel
  get :refund
  get :send_emails
  end
  
  end

  match 'admin/charts/:action' => 'admin/charts#index'
  match 'bugreport/crash' => 'email#crash_report'
  match '/:controller(/:action(/:id))'
end