Rails.application.routes.draw do
  resources :sessions, only: %i[create destroy]
  resources :types, only: %i[new show create]
  resources :users
  # except routes not being used - consider only from here -
  resources :tracktions
  resources :groups

  #-through to here

  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/auth/:provider/callback', to: 'sessions#create'

  # #shorten by removing transactions - attempt to render as partials
  get '/assigned', to: 'tracktions#assigned', as: 'assigned'
  get '/unassigned', to: 'tracktions#unassigned', as: 'unassigned'

  root 'users#splash'
end
