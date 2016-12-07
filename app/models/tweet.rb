# Unfortunately, Tilt is a reserved name in RoR. We will respect Twitter’s
# naming instead and only the front-end and routes will show Tilt/Retilt, etc…
class Tweet < ApplicationRecord
  belongs_to :user

  MIN_CONTENT_LENGTH = 1
  MAX_CONTENT_LENGTH = 139 # Not 140 cuz u gotta tilt m8
  validates :content, length: {
    minimum: MIN_CONTENT_LENGTH,
    maximum: MAX_CONTENT_LENGTH,
    message: %(
      Your tilt must be between #{MIN_CONTENT_LENGTH} and
      #{MAX_CONTENT_LENGTH} characters
    ),
    allow_nil: false, allow_blank: false
  }
end
