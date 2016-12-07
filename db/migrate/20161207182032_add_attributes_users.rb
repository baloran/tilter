class AddAttributesUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :username,     null: false, default: ""
      t.string :display_name, null: false, default: ""
      t.string :description
    end
  end
end
