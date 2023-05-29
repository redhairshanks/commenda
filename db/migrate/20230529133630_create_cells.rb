class CreateCells < ActiveRecord::Migration[7.0]
  def change
    create_table :cells, id: :uuid do |t|
      t.belongs_to :table_row, type: :uuid, foreign_key: true
      t.string :cell_type
      t.string :content
      t.timestamps
    end
  end
end
