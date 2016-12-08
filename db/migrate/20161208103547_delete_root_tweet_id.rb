class DeleteRootTweetId < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :root_tweet_id
  end
end
