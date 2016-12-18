class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tilts = Tweet.all
  end

  def show
    # Get a single tilt here
  end
end
