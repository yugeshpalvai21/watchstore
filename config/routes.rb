Rails.application.routes.draw do
  resources :products
  root 'pages#home'
  resources :charges, only: [:create]
end
