class AddDefaultToDisplayName < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :description, :string, :default => ""
  end
end
