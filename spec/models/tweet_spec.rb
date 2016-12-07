require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it 'can be created by an user' do
    user = create_valid_user

    Tweet.create(content: 'I’m really tilting today!', user_id: user.id)

    found = Tweet.joins(:user).last
    expect(found.content).to eq('I’m really tilting today!')
    expect(found.user).to eq(user)
  end

  it 'has a content between 1 and 139 characters' do
    user = create_valid_user

    tweet = Tweet.create(user_id: user.id)
    expect(tweet.valid?).to eq(false)

    tweet.content = 'I'
    expect(tweet.valid?).to eq(true)

    tweet.content = 'I’m really tilting today!'
    expect(tweet.valid?).to eq(true)

    tweet.content = (0..500).map { 'X' }.join
    expect(tweet.valid?).to eq(false)
  end
end

# Returns a valid user to avoid repetitions in tests
def create_valid_user
  User.create(
    username: 'baloran',
    display_name: 'bal0ran',
    password: 'password',
    email: 'baloranandco@gmail.com'
  )
end
