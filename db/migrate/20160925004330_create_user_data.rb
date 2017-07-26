class CreateUserData < ActiveRecord::Migration[5.0]
  def change
    create_table :user_data do |t|
      t.string :username
      t.text :data

      t.timestamps
    end
  end
end
