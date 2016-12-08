class Retweet < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  # Validates that a user can only retweet one specific tweet ONCE. A user can’t
  # have two retweets for the same tweet.
  validates :user_id, uniqueness: { scope: :tweet_id }
end
