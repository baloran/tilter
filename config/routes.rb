Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }, path: '', path_names: {
    sign_in: 'sign-in', 
    sign_out: 'sign-out',
    registration: 'sign-up'
  }

  get '/:username', to: 'users/profiles#profile'
end
