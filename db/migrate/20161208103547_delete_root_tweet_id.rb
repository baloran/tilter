class DeleteRootTweetId < ActiveRecord::Migration[5.0]
  def change
    remove_column :tweets, :root_tweet_id
  end
end
