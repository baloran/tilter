class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    following_list = current_user.follow_ids
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
      existing_hashtag = Hashtag.find(term: hashtag)

      if (existing_hashtag.nil?)
        tweet.hashtags.create(term: hashtag)
      else
        TweetHashtag.create(hashtag_id: existing_hashtag.id, tweet_id: tweet.id)
      end
    end

    redirect_to tilts_path
  end

  def show
    # Get a single tilt here
  end
end
