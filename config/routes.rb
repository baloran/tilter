Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  get '/:username', to: 'users/profiles#profile'

end
