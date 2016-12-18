class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tilts = Tweet.roots
  end

  def show
    # Get a single tilt here
  end
end
