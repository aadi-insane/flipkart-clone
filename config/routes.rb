Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'order_items/new'
  # get 'order_items/create'
  # get 'orders/show'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resource :cart, only: [:show] do
    resources :cart_items, only: [:create, :update, :destroy]
  end

  # CONTINUE FROM HERE 25 SEP 2025
  # resource :order, only: [:index, :show] do
  #   resources :order_items, only: [:create, :update]
  # end

  resources :orders, only: [:index, :show, :new, :create] do
    resources :order_items, only: [:create, :destroy]
    member do
      patch :cancel_order
      patch :return_order 
    end
  end

  post 'cart/empty', to: 'carts#empty_cart', as: :empty_cart
  # patch 'order/cancel', to: 'orders#cancel_order', as: :cancel_order

end
