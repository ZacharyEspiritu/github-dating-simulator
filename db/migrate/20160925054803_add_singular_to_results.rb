class AddSingularToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :practical, :boolean, default: false
  end
end
