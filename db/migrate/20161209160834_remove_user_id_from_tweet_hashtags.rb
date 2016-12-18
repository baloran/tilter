class RemoveUserIdFromTweetHashtags < ActiveRecord::Migration[5.0]
  def change
    remove_column :tweet_hashtags, :user_id
  end
end
