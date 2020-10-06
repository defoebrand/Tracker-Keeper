Rails.application.routes.draw do
  resources :sessions, only: %i[create destroy]
  resources :types, only: %i[new show create]
  resources :users
  resources :tracktions
  resources :groups

  get '/assigned', to: 'tracktions#assigned', as: 'assigned'
  get '/unassigned', to: 'tracktions#unassigned', as: 'unassigned'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root 'users#splash'
end
