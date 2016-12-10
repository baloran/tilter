require 'rails_helper'

RSpec.describe Retweet, type: :model do
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
    user.tweets.create(content: 'I’m really tilting today!')
  end

  it 'can be created by an user, on a tweet' do
    user = create_valid_user
    tweet = create_valid_tweet(user: user)
    Retweet.create(user_id: user.id, tweet_id: tweet.id)

    found = Retweet.joins(:user, :tweet).last
    expect(found.tweet).to eq(tweet)
    expect(found.user).to eq(user)
  end

  it 'can only be created once by the same user on the same tweet' do
    tweet = create_valid_tweet
    Retweet.create(user_id: tweet.user.id, tweet_id: tweet.id)
    Retweet.create(user_id: tweet.user.id, tweet_id: tweet.id)

    retweets = Retweet.all
    expect(retweets.count).to eq(1)

    user = User.joins(:retweets).find(tweet.user.id)
    expect(user.retweets.count).to eq(1)
  end

  it 'can be created by the user that created the tweet, and any other user' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')
    tweet = create_valid_tweet(user: user)

    Retweet.create(user_id: user.id, tweet_id: tweet.id)
    Retweet.create(user_id: user2.id, tweet_id: tweet.id)

    retweets = Retweet.all
    expect(retweets.size).to eq(2)
  end

  it 'can be destroyed' do
    tweet = create_valid_tweet
    retweet = Retweet.create(user_id: tweet.user.id, tweet_id: tweet.id)

    retweets = Retweet.all
    expect(retweets.count).to eq(1)

    retweet.destroy
    expect(retweets.count).to eq(0)
  end

  it 'is destroyed if its tweet is destroyed' do
    tweet = create_valid_tweet
    Retweet.create(user_id: tweet.user.id, tweet_id: tweet.id)

    retweets = Retweet.all
    expect(retweets.count).to eq(1)

    tweet.destroy
    expect(retweets.count).to eq(0)
  end

  it 'can be listed to get all the retweets of a specific user' do
    user = create_valid_user

    10.times do |number|
      tweet = user.tweets.create(content: number)
      Retweet.create(user_id: user.id, tweet_id: tweet.id)
    end

    expect(user.retweets.count).to eq(10)
  end
end
