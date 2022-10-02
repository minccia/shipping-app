Rails.application.routes.draw do
  root "home#index"
  resources :service_orders, only: %i[index new create show]
end
