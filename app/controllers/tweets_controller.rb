class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    following_list = current_user.follow_ids
    following_list.push(current_user.id)

    @tilts = Tweet.roots.where(user_id: following_list).order('created_at DESC')
    # @TODO: paginate
  end

  def create
    current_user.tweets.create(content: params[:content])
    redirect_to tilts_path
  end

  def show
    # Get a single tilt here
  end
end
