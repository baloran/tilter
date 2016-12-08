require 'spec_helper'

RSpec.describe Users::RegistrationsController, :type => :controller do
  render_views

  it 'can be created with form' do
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
    expect(response).to have_http_status(:success)
  end

  it 'cannot be created' do

  end
end
