Rails.application.routes.draw do
  get 'datafiles/new'

  root 'pages#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources 'users'
  resources 'datafiles'
  resources 'plots'
  resources 'dashboard'
end
