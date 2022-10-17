Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :service_orders, only: %i[index new create show] do 
    get 'in_operation', on: :collection
    get 'search', on: :collection
    get 'start', on: :member
    get 'finish', on: :member
    resources :lateness_explanations, only: %i[new create]
  end
  
  resources :transport_modalities, only: %i[index create show edit update]

  resources :vehicles, only: %i[index new create edit update show] do 
    get 'search', on: :collection
    get 'send_to_maintenance', on: :member
  end

  resources :table_entries, only: %i[new create edit update]
end
