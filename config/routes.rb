Rails.application.routes.draw do
  resources :bubbles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post '/api/auth/register', to: 'users#create'
  get '/api/user', to: 'users#show'
  put '/api/user', to: 'users#update'
  post '/api/auth/login', to: 'sessions#create'
  delete '/api/auth/logout', to: 'sessions#destroy'
end
