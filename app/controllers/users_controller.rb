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
    # Get all user with :id param following here
  end

  def followers
    # Get all user with :id param followers here
  end

  def likes
    # Get all user with :id param likes here
  end

  def settings
    # Get all current_user infos here
  end
end
