class AddRowsToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :tables, :rows, :uuid, array: true, default: []
  end
end
