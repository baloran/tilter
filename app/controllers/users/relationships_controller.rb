class Users::RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:toggle_follow]

  # GET /users/follow/followed_id
  def toggle_follow
    rs = Relationship.where(
      follower_id: current_user.id,
      followed_id: params['followed_id']
    ).first

    if rs
      rs.delete
    else
      create_relation = Relationship.create(
        follower_id: current_user.id,
        followed_id: params['followed_id']
      )

      return false unless create_relation.save

      respond_to do |format|
        if request.xhr?
          format.html do
            render json: rs.to_json
          end
        end
      end
    end
  end

  private

  def follow(user)
    # follow the user
  end

  def unfollow(user)
    # unfollow user
  end
end
