class Relationship < ApplicationRecord
  belongs_to :follow, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  # Validates that a user can only follow one other specific user ONCE. A user
  # can’t have two follows for the same user.
  validates :followed_id, presence: true, uniqueness: { scope: :follower_id }
  validates :follower_id, presence: true, uniqueness: { scope: :followed_id }

  # Validates that a user and can’t follow him/herself.
  validate :cant_self_follow

  def cant_self_follow
    errors.add(:base, 'You can’t follow yourself') if followed_id == follower_id
  end
end
