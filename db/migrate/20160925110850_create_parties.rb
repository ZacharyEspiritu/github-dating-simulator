class CreateParties < ActiveRecord::Migration[5.0]
  def change
    create_table :parties do |t|
      t.string :party_name
      t.text :usernames
      t.text :edit_key
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
