class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get all tilts here
  end

  def show
    # Get a single tilt here
  end
end
