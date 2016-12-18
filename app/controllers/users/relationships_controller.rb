class Users::RelationshipsController < ApplicationController
  
  before_action :authenticate_user!, only: [:toggleFollow]

  # GET /users/follow/followed_id
  def toggleFollow
    rs = Relationship.where(follower_id: current_user.id, followed_id: params['followed_id']).first
    if rs
      rs.delete()
    else
      createRelation = Relationship.create(follower_id: current_user.id, followed_id: params['followed_id'])
      if createRelation.save
        respond_to do |format|
          if request.xhr?
            format.html do
              render json: rs.to_json
            end
          end
        end
      else
        return false
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
