Rails.application.routes.draw do
  # except routes not being used - consider only from here -
  resources :tracktions
  resources :sessions
  resources :groups
  # resources :transactions
  resources :users
  resources :types
  #-through to here

  get 'logout', to: 'sessions#destroy', as: 'logout'

  # #create type controller
  # get '/new_type', to: 'tracktions#new_type', as: 'types'
  # post '/new_type', to: 'tracktions#create_type'
  # get '/show_type', to: 'tracktions#show_type'

  # #shorten by removing transactions - attempt to render as partials
  get '/assigned', to: 'tracktions#assigned', as: 'assigned'
  get '/unassigned', to: 'tracktions#unassigned', as: 'unassigned'

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'users#splash'
end
