class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  before_validation :assign_display_name

  MIN_USERNAME_LENGTH = 2
  MAX_USERNAME_LENGTH = 40
  validates :username, length: {
    minimum: MIN_USERNAME_LENGTH,
    maximum: MAX_USERNAME_LENGTH,
    message: "Your username must be between #{MIN_USERNAME_LENGTH} and "\
      "#{MAX_USERNAME_LENGTH} characters",
    allow_nil: false, allow_blank: false
  }

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
