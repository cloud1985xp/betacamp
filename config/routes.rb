Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :categories, only: :show do
    resources :products, controller: 'category_products', only: :show
  end
end
