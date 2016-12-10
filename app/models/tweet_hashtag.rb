class TweetHashtag < ApplicationRecord
  belongs_to :tweet
  belongs_to :hashtag

  validates :tweet_id, presence: true
  validates :hashtag_id, presence: true
end
