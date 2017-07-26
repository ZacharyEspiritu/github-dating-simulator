class AddAvatarUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :user_data, :avatar_url, :text
  end
end
