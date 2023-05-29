class AddNameToColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :columns, :col_name, :string
  end
end
