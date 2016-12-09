class Hashtag < ApplicationRecord
  has_many :tweet_hashtags
  has_many :tweets, through: :tweet_hashtags

  before_validation :slugify

  validates :slug, presence: true
  validates :term, presence: true

  protected

  def slugify
    self.slug = term.parameterize # Slugifies the term
  end
end
