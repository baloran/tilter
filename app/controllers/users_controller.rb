class UsersController < ApplicationController
  def show
    @user = User.includes(
      :tweets,
      :follows,
      :followers,
      :likes
    ).find(params[:id])
  end

  def following
    @user = User.includes(
      :tweets,
      :follows,
      :followers,
      :likes
    ).find(params[:user_id])
    @follow = User.find(@user.follows.map(&:followed_id.to_proc))
  end

  def followers
    @user = User.includes(
      :tweets,
      :follows,
      :followers,
      :likes
    ).find(params[:user_id])
    @follow = User.find(@user.followers.map(&:id.to_proc))
  end

  def likes
    # Get all user with :id param likes here
  end

  def settings
    # Get all current_user infos here
  end
end
