class TableRow < ApplicationRecord

	belongs_to :table
	has_many :cells

	def create_cells(columns)
		cells = []
		columns.each do |k, v|
			cell = Cell.create(table_row: self, column_id: k, content: v)
			if cell.present? && cell.errors.blank?
				cells << cell
			end
		end
		cells
	end

	def create_new_cols(cols)
		cells = []
		cols.each do |col|
			cell = Cell.create(table_row: self, column_id: col.id, content: nil)
			if cell.present? && cell.errors.blank?
				cells << cell
			end
		end
		cells
	end

end