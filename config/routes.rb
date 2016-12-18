Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }, path: '', path_names: {
    sign_in: 'sign-in', 
    sign_out: 'sign-out',
    registration: 'sign-up'
  }

  get '/:username', to: 'users/profiles#profile'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'tweets#index', as: :root
  get 'tilts' => redirect('/')
  resources :tilts, :controller => 'tweets'

  get '/settings' => 'users#settings'
  get '/users/:id' => 'users#show'
  get '/users/:id/following' => 'users#following'
  get '/users/:id/followers' => 'users#followers'
  get '/users/:id/likes' => 'users#likes'
end
