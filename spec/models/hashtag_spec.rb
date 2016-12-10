require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  # Returns a valid user to avoid repetitions in tests
  def create_valid_user
    User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
  end

  it 'can be created without being associated to a tweet' do
    Hashtag.create(term: 'standAloneHashtag')

    found = Hashtag.all
    expect(found.count).to eq(1)
    expect(found.last.term).to eq('standAloneHashtag')
  end

  it 'can be created while associated to a tweet' do
    tweet_hashtags = %w(this is a test tweet)
    tweet_content = "##{tweet_hashtags.join(' #')}"

    user = create_valid_user
    tweet = user.tweets.create(content: tweet_content)

    tweet_hashtags.each do |hashtag|
      tweet.hashtags.create(term: hashtag)
    end

    hashtags = Hashtag.all

    tweet_hashtags.each_with_index do |hashtag, index|
      expect(hashtags[index].term).to eq(hashtag)
    end
  end

  it 'is automatically assigned a slug' do
    hashtag = Hashtag.create(term: 'standAloneHashtag')
    expect(hashtag.slug).to eq('standalonehashtag')
  end

  it 'only has one record in the database for similar hashtags…' do
    user = create_valid_user
    tweet = user.tweets.create(content: '#first #second #first')

    tweet.hashtags.create(term: 'first')
    tweet.hashtags.create(term: 'second')
    tweet.hashtags.create(term: 'first')
    Hashtag.create(term: 'second')

    hashtags = Hashtag.all
    expect(hashtags.count).to eq(2)
  end

  it '…but does allow multiple records in the join table' do
    user = create_valid_user
    tweet = user.tweets.create(content: '#first #second #first')
    tweet2 = user.tweets.create(content: '#first')

    # This logic will be handled in the controller. We do it manually here for
    # testing purposes. See the Tweet controller tests.
    first_hashtag = tweet.hashtags.create(term: 'first')
    tweet.hashtags.create(term: 'first')
    tweet.hashtags.create(term: 'second')
    TweetHashtag.create(hashtag_id: first_hashtag.id, tweet_id: tweet2.id)

    tweet_hashtags = TweetHashtag.all
    expect(tweet_hashtags.count).to eq(3)
  end

  it 'can be listed to get all the hashtags used in a specific tweet' do
    user = create_valid_user
    tweet = user.tweets.create(content: '#first #second #first')

    tweet.hashtags.create(term: 'first')
    tweet.hashtags.create(term: 'second')

    expect(tweet.hashtags.count).to eq(2)
    expect(tweet.hashtags.first.term).to eq('first')
    expect(tweet.hashtags.last.term).to eq('second')
  end
end
