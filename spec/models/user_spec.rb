require 'spec_helper'

RSpec.describe 'User', type: :model do
  it 'can be created' do
    User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    found = User.last
    expect(found.username).to eq('baloran')
    expect(found.display_name).to eq('bal0ran')
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

  it 'is automatically assigned its username as display name if none is set' do
    user = User.create(
      username: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    expect(user.username).to eq('baloran')
    expect(user.display_name).to eq('baloran')
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
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    expect(user.valid?).to eq(true)

    # Here, the uniqueness is handled by ActiveRecord directly and will
    # raise an exception as expected.
    expect do
      User.create(
        username: 'baloran',
        password: 'password',
        email: 'stammeister@gmail.com'
      )
    end.to raise_exception(ActiveRecord::RecordNotUnique)
  end

  it 'can have a username between 2 and 40 characters' do
    user = User.create(
      display_name: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    expect(user.valid?).to eq(false)

    user.username = 'b'
    expect(user.valid?).to eq(false)

    user.username = (0..100).map { 'X' }.join
    expect(user.valid?).to eq(false)

    user.username = 'ba'
    expect(user.valid?).to eq(true)

    user.username = 'baloran'
    expect(user.valid?).to eq(true)
  end

  it 'has a proper error message for username not being valid' do
    user = User.create(
      display_name: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    expect(user.errors.messages[:username].first).not_to be_empty
  end

  it 'can have a display name between 2 and 40 characters' do
    user = User.create(
      username: 'baloran',
      display_name: 'b',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
    expect(user.valid?).to eq(false)

    user.display_name = (0..100).map { 'X' }.join
    expect(user.valid?).to eq(false)

    user.display_name = 'ba'
    expect(user.valid?).to eq(true)

    user.display_name = 'baloran'
    expect(user.valid?).to eq(true)
  end

  it 'has a proper error message for display name not being valid' do
    user = User.create(
      username: 'baloran',
      display_name: 'b',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )

    expect(user.errors.messages[:display_name].first).not_to be_empty
  end

  it 'requires a valid email' do
    user = User.new
    user.username = 'baloran'
    user.password = 'password'

    user.email = 'baloranandco'
    expect(user.valid?).to eq(false)

    user.email = 'baloranandcogmail.com'
    expect(user.valid?).to eq(false)

    user.email = 'baloranandco@gmail.com'
    expect(user.valid?).to eq(true)
  end

  it 'has a proper error message for email not being valid' do
    user = User.create(
      username: 'baloran',
      display_name: 'baloran',
      password: 'password',
      email: 'baloranandco'
    )

    expect(user.errors.messages[:email].first).not_to be_empty
  end

  it 'can have a description that has a maximum of 200 characters' do
    user = User.create(
      username: 'baloran',
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

  it 'has a proper error message for description being too long' do
    user = User.create(
      username: 'baloran',
      password: 'password',
      email: 'baloranandco@gmail.com',
      description: (0..500).map { 'X' }.join
    )

    expect(user.errors.messages[:description].first).not_to be_empty
  end
end
