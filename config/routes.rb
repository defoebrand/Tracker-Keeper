Rails.application.routes.draw do
  resources :sessions
  resources :groups
  resources :transactions
  resources :users
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
end
