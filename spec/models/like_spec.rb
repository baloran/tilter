require 'rails_helper'

RSpec.describe Like, type: :model do
  # Returns a valid user to avoid repetitions in tests
  def create_valid_user(username: 'baloran', email: 'baloranandco@gmail.com')
    User.create(
      username: username,
      display_name: 'bal0ran',
      password: 'password',
      email: email
    )
  end

  # Returns a valid tweet to avoid repetitions in tests
  def create_valid_tweet(user: nil)
    user = create_valid_user if user.nil?
    Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
  end

  it 'can be created by an user, on a tweet' do
    user = create_valid_user
    tweet = create_valid_tweet(user: user)
    Like.create(user_id: user.id, tweet_id: tweet.id)

    found = Like.joins(:user, :tweet).last
    expect(found.tweet).to eq(tweet)
    expect(found.user).to eq(user)
  end

  it 'can only be created once by the same user on the same tweet' do
    tweet = create_valid_tweet
    Like.create(user_id: tweet.user.id, tweet_id: tweet.id)
    Like.create(user_id: tweet.user.id, tweet_id: tweet.id)

    likes = Like.all
    expect(likes.count).to eq(1)

    user = User.joins(:likes).find(tweet.user.id)
    expect(user.likes.count).to eq(1)
  end

  it 'can be created by the user that created the tweet, and any other user' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')
    tweet = create_valid_tweet(user: user)

    Like.create(user_id: user.id, tweet_id: tweet.id)
    Like.create(user_id: user2.id, tweet_id: tweet.id)

    likes = Like.all
    expect(likes.size).to eq(2)
  end

  it 'can be destroyed' do
    tweet = create_valid_tweet
    like = Like.create(user_id: tweet.user.id, tweet_id: tweet.id)

    likes = Like.all
    expect(likes.count).to eq(1)

    like.destroy
    expect(likes.count).to eq(0)
  end

  it 'is destroyed if its tweet is destroyed' do
    tweet = create_valid_tweet
    Like.create(user_id: tweet.user.id, tweet_id: tweet.id)

    likes = Like.all
    expect(likes.count).to eq(1)

    tweet.destroy
    expect(likes.count).to eq(0)
  end

  it 'can be listed to get all the likes of a specific user' do
    user = create_valid_user

    10.times do |number|
      tweet = Tweet.create(user_id: user.id, content: number)
      Like.create(user_id: user.id, tweet_id: tweet.id)
    end

    expect(user.likes.count).to eq(10)
  end
end
