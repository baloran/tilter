class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    following_list = current_user.follows.map(&:followed_id.to_proc)
    following_list.push(current_user.id)

    @tilts = Tweet.roots.where(user_id: following_list).order('created_at DESC')
    # @TODO: paginate
  end

  def create
    tweet = current_user.tweets.create(
      content: params[:content],
      parent_tweet_id: params[:parent_tweet_id]
    )

    hashtags = params[:content].scan(/\B#\w+/)

    hashtags.each do |hashtag|
      hashtag.slice!(0) # Remove `#` from the hashtag
      existing_hashtag = Hashtag.where(term: hashtag).first

      if (existing_hashtag.nil?)
        tweet.hashtags.create(term: hashtag)
      else
        TweetHashtag.create(hashtag_id: existing_hashtag.id, tweet_id: tweet.id)
      end
    end

    redirect_to tilt_path(tweet)
  end

  def show
    @tilt = Tweet.find(params[:id])
    @root = @tilt.root
    @answers = @tilt.children
  end
end
