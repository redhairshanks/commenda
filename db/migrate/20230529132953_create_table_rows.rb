class CreateTableRows < ActiveRecord::Migration[7.0]
  def change
    create_table :table_rows, id: :uuid do |t|
      t.belongs_to :table, type: :uuid, foreign_key: true
      t.uuid :cells, array: true
      t.timestamps
    end
  end
end
