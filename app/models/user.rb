class User < ApplicationRecord
  # Others available devise modules are:
  # :confirmable, :lockable, :timeoutable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable,
         :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many(
    :follows,
    dependent: :destroy,
    foreign_key: 'follower_id',
    class_name: 'Relationship'
  )
  has_many(
    :followers,
    dependent: :destroy,
    foreign_key: 'followed_id',
    class_name: 'Relationship'
  )

  before_validation :assign_display_name

  # Format validation is handled by Devise for email & password
  validates :email, presence: true
  validates :password, presence: true

  MIN_USERNAME_LENGTH = 2
  MAX_USERNAME_LENGTH = 40
  validates :username,
    length: {
      minimum: MIN_USERNAME_LENGTH,
      maximum: MAX_USERNAME_LENGTH,
      message: "Your username must be between #{MIN_USERNAME_LENGTH} and "\
        "#{MAX_USERNAME_LENGTH} characters",
      allow_nil: false, allow_blank: false
    },
    format: {
      with: /\A[a-z0-9\-_]+\z/i,
      message: 'Your username must only contain alphanumeric characters, '\
        'dashes and underscores'
    },
    presence: true,
    uniqueness: { case_sensitive: false }

  MIN_DISPLAY_NAME_LENGTH = 2
  MAX_DISPLAY_NAME_LENGTH = 40
  validates :display_name, length: {
    minimum: MIN_DISPLAY_NAME_LENGTH,
    maximum: MAX_DISPLAY_NAME_LENGTH,
    message: "Your display name must be between #{MIN_DISPLAY_NAME_LENGTH} and"\
      "#{MAX_DISPLAY_NAME_LENGTH} characters",
    allow_nil: false, allow_blank: false
  }

  MAX_DESCRIPTION_LENGTH = 200
  validates :description, length: {
    maximum: MAX_DESCRIPTION_LENGTH,
    message:
      "Your description must be less than #{MAX_DESCRIPTION_LENGTH} characters",
    allow_nil: false, allow_blank: true
  }

  def assign_display_name
    self.display_name = username if display_name.blank?
  end
end
