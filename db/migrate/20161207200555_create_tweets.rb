class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :user_id
      t.integer :parent_tilt_id
      t.integer :root_tilt_id

      t.timestamps
    end
  end
end
