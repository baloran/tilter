class CreateRetweets < ActiveRecord::Migration[5.0]
  def change
    create_table :retweets do |t|
      t.integer :tweet_id
      t.integer :user_id

      t.timestamps
    end
  end
end
