class UsersController < ApplicationController
  def show
    @user = User.includes(
      :tweets,
      :retweets,
      :follows,
      :followers,
      :likes
    ).find(params[:id])

    @tilts = @user.tweets
  end

  def following
    @user = User.includes(:follows).find(params[:user_id])
    @follow = User.find(@user.follows.map(&:followed_id.to_proc))
  end

  def followers
    @user = User.includes(:followers).find(params[:user_id])
    @follow = User.find(@user.followers.map(&:follower_id.to_proc))
  end

  def likes
    # Get all user with :id param likes here
  end

  def settings
    # Get all current_user infos here
  end
end
