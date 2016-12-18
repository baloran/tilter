class CreateTweetHashtags < ActiveRecord::Migration[5.0]
  def change
    create_table :tweet_hashtags do |t|
      t.integer :tweet_id
      t.integer :hashtag_id
      t.integer :user_id

      t.timestamps
    end
  end
end
