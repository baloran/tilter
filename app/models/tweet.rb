# Unfortunately, Tilt is a reserved name in RoR. We will respect Twitter’s
# naming instead and only the front-end and routes will show Tilt/Retilt, etc…
class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweet_hashtags, dependent: :destroy
  has_many :hashtags, through: :tweet_hashtags
  # Add hierarchy to the model: every tweet can be the parent of other tweets,
  # that can have children themselves. We can easily get the root tweet with the
  # methods provided by the closure_tree gem.
  acts_as_tree(parent_column_name: :parent_tweet_id, dependent: :destroy)

  MIN_CONTENT_LENGTH = 1
  MAX_CONTENT_LENGTH = 139 # Not 140 cuz u gotta tilt m8
  validates :content, length: {
    minimum: MIN_CONTENT_LENGTH,
    maximum: MAX_CONTENT_LENGTH,
    message: "Your tilt must be between #{MIN_CONTENT_LENGTH} and "\
      "#{MAX_CONTENT_LENGTH} characters",
    allow_nil: false, allow_blank: false
  }

  validates :user_id, presence: true
end
