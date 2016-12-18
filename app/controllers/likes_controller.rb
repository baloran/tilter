class LikesController < ApplicationController
  before_action :authenticate_user!

  def toggle_likes
    like = Like.where(user_id: current_user.id, tweet_id: params['tweet_id']).first 
    if like
      like.delete()
    else
      createLike = Like.create(user_id: current_user.id, tweet_id: params['tweet_id'])
      if createLike.save
        return true
      else
        return false
      end
    end
  end
end
