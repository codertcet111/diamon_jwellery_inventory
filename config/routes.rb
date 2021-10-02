Rails.application.routes.draw do
  resources :stock_sub_types
  resources :stock_types
  get '/stock_details/:stock_id' => 'info#stock_details'
  get '/sell_item_amount' => 'info#sell_item_amount'
  root 'rails_admin/main#dashboard'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
