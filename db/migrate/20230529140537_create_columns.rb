class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns, id: :uuid do |t|
      t.belongs_to :table, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
