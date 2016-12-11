Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'tweets#index', as: :root
  get 'tilts' => redirect('/')
  resources :tilts, :controller => 'tweets'

  devise_for :users
  get '/settings' => 'users#settings'
  get '/users/:id' => 'users#show'
  get '/users/:id/following' => 'users#following'
  get '/users/:id/followers' => 'users#followers'
  get '/users/:id/likes' => 'users#likes'
end
