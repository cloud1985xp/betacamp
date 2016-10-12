Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :categories, only: :show do
    resources :products, controller: 'category_products', only: :show do
      post 'add', on: :member
      resources :comments, controller: 'product_comments', only: :create
    end
    resources :comments, controller: 'category_comments', only: :create
  end

  resource :cart
  resources :orders, only: [:index, :new, :create, :show] do
    post :checkout, on: :member
  end

  post 'pay2go/return' => 'pay2go#callback'
  post 'pay2go/notify' => 'pay2go#notify'

  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

  namespace :admin do
    root 'index#index'
    resources :categories
    resources :users
    resources :products do
      post 'export', on: :collection
    end
    resources :orders, except: [:new, :create]
  end
end
