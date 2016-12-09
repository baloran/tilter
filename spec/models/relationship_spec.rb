require 'rails_helper'

RSpec.describe Relationship, type: :model do
  # Returns a valid user to avoid repetitions in tests
  def create_valid_user(username: 'baloran', email: 'baloranandco@gmail.com')
    User.create(
      username: username,
      password: 'password',
      email: email
    )
  end

  it 'can be created between two users' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')

    Relationship.create(followed_id: user.id, follower_id: user2.id)
    Relationship.create(followed_id: user2.id, follower_id: user.id)

    expect(user.follows.count).to eq(1)
    expect(user.followers.count).to eq(1)
    expect(user2.follows.count).to eq(1)
    expect(user2.followers.count).to eq(1)
  end

  it 'can only be created once between a user and another user' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')

    2.times do
      Relationship.create(followed_id: user.id, follower_id: user2.id)
    end

    2.times do
      Relationship.create(followed_id: user2.id, follower_id: user.id)
    end

    expect(user2.follows.count).to eq(1)
    expect(user2.followers.count).to eq(1)

    expect(user.follows.count).to eq(1)
    expect(user.followers.count).to eq(1)

    relationships = Relationship.all
    expect(relationships.count).to eq(2)
  end

  it 'can’t be created by a user on him/herself' do
    user = create_valid_user

    Relationship.create(followed_id: user.id, follower_id: user.id)

    relationships = Relationship.all
    expect(relationships.count).to eq(0)
    expect(user.follows.count).to eq(0)
    expect(user.followers.count).to eq(0)
  end

  it 'can be destroyed' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')

    relationship = Relationship.create(
      followed_id: user.id,
      follower_id: user2.id
    )

    relationships = Relationship.all
    expect(relationships.count).to eq(1)

    expect(user.followers.count).to eq(1)
    expect(user2.follows.count).to eq(1)

    relationship.destroy

    relationships = Relationship.all
    expect(relationships.count).to eq(0)

    expect(user.followers.count).to eq(0)
    expect(user2.follows.count).to eq(0)
  end

  it 'can be listed to get all the follows of a specific user' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')

    relationship = Relationship.create(
      followed_id: user2.id,
      follower_id: user.id
    )

    expect(user.follows.count).to eq(1)
    expect(user.follows.first).to eq(relationship)
  end

  it 'can be listed to get all the followers of a specific user' do
    user = create_valid_user
    user2 = create_valid_user(username: 'baloran2', email: 'baloran2@gmail.com')

    relationship = Relationship.create(
      followed_id: user.id,
      follower_id: user2.id
    )

    expect(user.followers.count).to eq(1)
    expect(user.followers.first).to eq(relationship)
  end
end
