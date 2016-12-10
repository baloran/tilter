Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  get '/' => 'tweets#index'
  get '/tilt/:id' => 'tweets#show'

  get '/user/settings' => 'users#settings'
  get '/user/:id' => 'users#show'
  get '/user/:id/following' => 'users#following'
  get '/user/:id/followers' => 'users#followers'
  get '/user/:id/likes' => 'users#likes'
end
