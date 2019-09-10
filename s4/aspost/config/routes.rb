Rails.application.routes.draw do
  root 'main#index'
  resources :users
  resources :comments
  resources :posts
end
