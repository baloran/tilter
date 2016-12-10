require 'spec_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  render_views

  it 'can be created with form' do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, params: {
      user: {
        username: 'baloran',
        email: 'baloranandco@gmail.com',
        password: 'mdrjesuisuntestdeoufjpp',
        password_confirmation: 'mdrjesuisuntestdeoufjpp',
        display_name: 'baloran'
      }
    }

    expect(User.count).to eq(1)
    user = User.last

    expect(user.username).to eq('baloran')
    expect(user.email).to eq('baloranandco@gmail.com')
    expect(response).to have_http_status(302)
  end

  it 'cannot be created' do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create, params: {
      user: {
        username: 'baloran',
        password: 'mdrjesuisuntestdeoufjpp',
        password_confirmation: 'mdrjesuisuntestdeoufjpp'
      }
    }

    expect(User.count).to eq(0)
    # expect(response).to have_http_status(:success)
  end

  it 'can connect' do
    post :sign_in, params: {
      
    }
  end
end

RSpec.describe Users::ProfilesController, type: :controller do
  render_views

  it 'can see profile' do
    user = User.create(
      username: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    get :profile, params: { username: 'baloran' }

    print response.body.inspect

    expect(response.body).to include('baloran')
    expect(response).to have_http_status(:success)
  end
end
