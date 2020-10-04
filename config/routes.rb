Rails.application.routes.draw do
  resources :tracktions
  resources :sessions
  resources :groups
  resources :transactions
  resources :users
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/splash', to: 'users#splash', as: 'home'
  get '/new_type', to: 'transactions#new_type', as: 'types'
  post '/new_type', to: 'transactions#create_type'
  get '/show_type', to: 'transactions#show_type'
  get '/assigned_transactions', to: 'transactions#assigned_transactions', as: 'assigned'
  get '/unassigned_transactions', to: 'transactions#unassigned_transactions', as: 'unassigned'
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'users#splash'
end
