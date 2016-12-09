class CreateTweetHierarchies < ActiveRecord::Migration[5.0]
  def change
    create_table :tweet_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :tweet_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "tweet_anc_desc_idx"

    add_index :tweet_hierarchies, [:descendant_id],
      name: "tweet_desc_idx"
  end
end
