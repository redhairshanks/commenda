class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables, id: :uuid do |t|
      t.string :name 
      t.integer :total_columns
      t.timestamps
    end
  end
end
