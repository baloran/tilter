class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable

  MAX_DESCRIPTION_LENGTH = 200
  validates :description, length: {
    maximum: MAX_DESCRIPTION_LENGTH,
    message:
      "Your description must be less than #{MAX_DESCRIPTION_LENGTH} characters",
    allow_nil: false, allow_blank: true
  }
end
