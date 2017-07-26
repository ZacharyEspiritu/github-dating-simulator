class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.string :result_name
      t.text :data
      t.timestamps
    end
  end
end
