Rails.application.routes.draw do
  resources :products
  root 'pages#home'
  resources :charges, only: [:create] do
    member do
      get 'success'
      get 'cancel'
    end
  end
end
