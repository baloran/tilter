class RenameTiltToTweet < ActiveRecord::Migration[5.0]
  def change
    rename_column :tweets, :parent_tilt_id, :parent_tweet_id
    rename_column :tweets, :root_tilt_id, :root_tweet_id
  end
end
