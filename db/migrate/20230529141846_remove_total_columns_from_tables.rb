class RemoveTotalColumnsFromTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :tables, :total_columns
  end
end
