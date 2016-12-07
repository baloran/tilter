require 'spec_helper'

RSpec.describe 'User', type: :model do
  it 'can be created' do
    User.create(
      username: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    found = User.last
    expect(found.username).to eq('baloran')
    expect(found.email).to eq('baloranandco@gmail.com')
  end

  it 'requires a username, a display name, an email and a password' do
    user = User.new
    expect(user.valid?).to eq(false)

    user.username = 'baloran'
    expect(user.valid?).to eq(false)

    user.display_name = 'bal0ran'
    expect(user.valid?).to eq(false)

    user.email = 'baloranandco@gmail.com'
    expect(user.valid?).to eq(false)

    user.password = 'password'
    expect(user.valid?).to eq(true)
  end

  it 'can’t have the same email as another user' do
    user = User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    expect(user.valid?).to eq(true)

    other_user = User.create(
      username: 'stamm',
      display_name: 'stammeister',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    # As uniqueness of email is handled by Devise, it won’t raise an exception.
    expect(other_user.valid?).to eq(false)
  end

  it 'can’t have the same username as another user' do
    user = User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    expect(user.valid?).to eq(true)

    # Here, the uniqueness is handled by ActiveRecord directly and will
    # raise an exception as expected.
    expect do
      User.create(
        username: 'baloran',
        display_name: 'bal0ran',
        password: 'password',
        email: 'stammeister@gmail.com'
      )
    end.to raise_exception(ActiveRecord::RecordNotUnique)
  end

  it 'requires a valid email' do
    user = User.new
    user.username = 'baloran'
    user.display_name = 'bal0ran'
    user.password = 'password'

    user.email = 'baloranandco'
    expect(user.valid?).to eq(false)

    user.email = 'baloranandcogmail.com'
    expect(user.valid?).to eq(false)

    user.email = 'baloranandco@gmail.com'
    expect(user.valid?).to eq(true)
  end

  it 'can have a description that has a maximum of 200 characters' do
    user = User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    user.description = ''
    expect(user.valid?).to eq(true)

    user.description = 'A valid description'
    expect(user.valid?).to eq(true)

    user.description = (0..500).map { 'X' }.join
    expect(user.valid?).to eq(false)
  end
end
