Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'tweets#index', as: :root
  get 'tilts' => redirect('/')
  resources :tilts, :controller => 'tweets'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }, path: '', path_names: {
    sign_in: 'sign-in',
    sign_out: 'sign-out',
    registration: 'user'
  }

  get '/:username', to: 'users/profiles#profile'
  get '/settings' => 'users#settings'

  resources :users do
    get '/following' => 'users#following'
    get '/followers' => 'users#followers'
    get '/likes' => 'users#likes'
    get '/like/:tweet_id' => 'likes#toggle_likes', as: :toggle_likes
    get '/users/follow/:followed_id' => 'users/relationships#toggleFollow', as: :toggle_follow_user
  end
end
