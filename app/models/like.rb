class Like < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  # Validates that a user can only like one specific tweet ONCE. A user can’t
  # have two likes for the same tweet.
  validates :user_id, presence: true, uniqueness: { scope: :tweet_id }
  validates :tweet_id, presence: true
end
