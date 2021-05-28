Rails.application.routes.draw do
  devise_for :users
  resources :products
  root 'pages#home'
  resources :charges, only: [:create] do
    member do
      get 'success'
      get 'cancel'
    end
  end
end
