class ChangeCellsInTableRows < ActiveRecord::Migration[7.0]
  def change
    remove_column :table_rows, :cells
    add_column :table_rows, :cells, :uuid, array: true, default: []
  end
end
