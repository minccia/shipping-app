Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :service_orders, only: %i[index new create show]
  resources :transport_modalities, only: %i[index create show]
end
