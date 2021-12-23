Rails.application.routes.draw do
  resources :bubbles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/api/auth/register', to: 'users#create'
  get '/api/user', to: 'users#show'
  put '/api/user', to: 'users#update'
  post '/api/auth/login', to: 'sessions#create'
  delete '/api/auth/logout', to: 'sessions#destroy'
  post '/api/bubbles', to: 'bubbles#create'
  get '/api/bubbles', to: 'bubbles#index'
  post '/api/bubbles/:bubble_id', to: 'game_session#process_game'
  get '/api/bubbles/:bubble_id', to: 'bubbles#single'
  get '/api/bubbles/:bubble_id/stats', to: 'bubbles#stats'
end

