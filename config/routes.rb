Rails.application.routes.draw do
  resources :sessions
  resources :groups
  resources :transactions
  resources :users
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/splash', to: 'users#splash', as: 'home'
  get '/new_type', to: 'transactions#new_type', as: 'types'
  post '/new_type', to: 'transactions#create_type'
  # get '/about', to: 'portal#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  # match '/auth/:provider/callback', to: 'sessions#create', via: %i[get post]
  # match '/auth/failure', to: 'sessions#failure', via: %i[get post]
  root 'users#splash'
end
