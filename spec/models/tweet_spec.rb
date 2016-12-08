require 'rails_helper'

RSpec.describe Tweet, type: :model do
  # Returns a valid user to avoid repetitions in tests
  def create_valid_user
    User.create(
      username: 'baloran',
      display_name: 'bal0ran',
      password: 'password',
      email: 'baloranandco@gmail.com'
    )
  end

  it 'can be created by an user' do
    user = create_valid_user

    Tweet.create(content: 'I’m really tilting today!', user_id: user.id)

    found = Tweet.joins(:user).last
    expect(found.content).to eq('I’m really tilting today!')
    expect(found.user).to eq(user)
  end

  it 'can be deleted, deleting all of its children with it' do
    user = create_valid_user

    tweet = Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
    child_tweet = tweet.children.create(
      content: 'I’m the children of the first tweet!',
      user_id: user.id
    )
    child_tweet.children.create(
      content: 'I’m a children of the second tweet!',
      user_id: user.id
    )

    expect(tweet.children.size).to eq(1)
    expect(tweet.descendants.size).to eq(2)

    tweet.destroy

    expect(tweet.children.size).to eq(0)
    expect(tweet.descendants.size).to eq(0)

    found = Tweet.last
    expect(found).to eq(nil)
  end

  it 'can have children tweets' do
    user = create_valid_user

    tweet = Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
    child_tweet1 = tweet.children.create(
      content: 'I’m the children of the first tweet!',
      user_id: user.id
    )
    child_tweet2 = tweet.children.create(
      content: 'I’m another children of the first tweet!',
      user_id: user.id
    )

    expect(tweet.children).to be_a(ActiveRecord::Associations::CollectionProxy)
    expect(tweet.children).to include(child_tweet1, child_tweet2)
    expect(tweet.children.size).to eq(2)
    expect(tweet.children[0].content).to eq(
      'I’m the children of the first tweet!'
    )
    expect(tweet.children[1].content).to eq(
      'I’m another children of the first tweet!'
    )
  end

  it 'can have grandchildren tweets' do
    user = create_valid_user

    tweet = Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
    child_tweet = tweet.children.create(
      content: 'I’m the children of the first tweet!',
      user_id: user.id
    )
    child_tweet.children.create(
      content: 'I’m a children of the second tweet!',
      user_id: user.id
    )

    expect(tweet.children.size).to eq(1)
    expect(child_tweet.children.size).to eq(1)
    expect(tweet.descendants.size).to eq(2)
  end

  it 'has methods to retrieve its parent and root tweet' do
    user = create_valid_user

    tweet = Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
    child_tweet = tweet.children.create(
      content: 'I’m the children of the first tweet!',
      user_id: user.id
    )
    grandchild_tweet = child_tweet.children.create(
      content: 'I’m a children of the second tweet!',
      user_id: user.id
    )

    expect(child_tweet.parent).to eq(tweet)
    expect(grandchild_tweet.root).to eq(tweet)
  end

  it 'has no parent and is its own root tweet if it is a root tweet itself' do
    user = create_valid_user

    tweet = Tweet.create(content: 'I’m really tilting today!', user_id: user.id)
    expect(tweet.parent).to eq(nil)
    expect(tweet.root).to eq(tweet)
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
