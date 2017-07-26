class AddStuff < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :percentages, :text
  end
end
