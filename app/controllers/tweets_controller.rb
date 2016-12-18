class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    following_list = current_user.follow_ids
    following_list.push(current_user.id)

    @tilts = Tweet.roots.where(user_id: following_list)
  end

  def create
    current_user.tweets.create(content: params[:content])
  end

  def show
    # Get a single tilt here
  end
end
