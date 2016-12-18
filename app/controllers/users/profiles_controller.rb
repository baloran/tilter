class Users::ProfilesController < ApplicationController

  # Get /:username
  def profile
    @user = User.where(username: params[:username]).first
  end
end
