class AddSlugToHashtag < ActiveRecord::Migration[5.0]
  def change
    add_column :hashtags, :slug, :string
  end
end
