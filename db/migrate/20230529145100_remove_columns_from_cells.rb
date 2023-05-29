class RemoveColumnsFromCells < ActiveRecord::Migration[7.0]
  def change
    remove_column :cells, :columns_id
    add_reference :cells, :column, type: :uuid, foreign_key: true
    remove_column :table_rows, :cells
  end
end
