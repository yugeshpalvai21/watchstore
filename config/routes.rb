Rails.application.routes.draw do
  devise_for :users
  resources :products
  root 'pages#home'
  resources :charges, only: [:create] do
    collection do
      get 'success'
      get 'cancel'
    end
  end

  resources :line_items
  resources :carts
end
