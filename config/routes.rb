Rails.application.routes.draw do
  resources :taxes
  resources :company_details
  resources :ledger_expenses
  resources :ledgers
  resources :ledger_groups
  resources :stock_sub_types
  resources :stock_types
  post '/purchase/:id/download_purchase_invoice' => 'purchases#download_purchase_invoice'
  get '/stock_details/:stock_id' => 'info#stock_details'
  get '/sell_item_amount' => 'info#sell_item_amount'
  root 'rails_admin/main#dashboard'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
