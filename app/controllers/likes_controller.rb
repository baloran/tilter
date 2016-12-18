class LikesController < ApplicationController
  before_action :authenticate_user!

  def toggle_likes
    like = Like.where(
      user_id: current_user.id,
      tweet_id: params['tweet_id']
    ).first

    if like
      like.delete
    else
      create_like = Like.create(
        user_id: current_user.id,
        tweet_id: params['tweet_id']
      )

      return create_like.save
    end
  end
end
