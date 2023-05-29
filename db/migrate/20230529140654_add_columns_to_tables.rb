class AddColumnsToTables < ActiveRecord::Migration[7.0]
  def change
    add_column :tables, :cols, :uuid, array: true, default: []
    add_column :columns, :col_type, :string
    remove_column :cells, :cell_type
    add_reference :cells, :columns, null: false, type: :uuid
  end
end
