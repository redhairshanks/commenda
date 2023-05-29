class Table < ApplicationRecord

	has_many :table_rows

	enum col_types: {
		date: 'date',
		text: 'text'
	}

	def create_columns(columns)
		cols = []
		columns.each do |col|
			col = Column.create(table: self, col_type: col[:type], col_name: col[:name])
			if col.present? && col.errors.blank?
				cols << col
			end
		end
		col_ids = cols.map{|x| x[:id]}
		new_cols = self.cols.push(col_ids).flatten!
		self.cols = new_cols
		self.save
		if self.present? && self.errors.blank?
			return cols
		end
		return nil
	end

	def add_row(columns)
		row = nil
		cols_valid = validate_columns(self.cols, columns.keys)
		if cols_valid
			row = TableRow.create(table: self)
			if row.present? && row.errors.blank?
				self.rows << row.id
				self.save
				if self.present? && self.errors.blank?
					cells = row.create_cells(columns)
				end	
			end	
		end
		row
	end

	def delete_row(row_id)
		result = false
		is_row = TableRow.find_by(id: row_id)
		if is_row.present?
			cells = Cell.where(table_row: is_row)
			if cells.present? 
				dest = cells.destroy_all
				if dest.present?
					dest = is_row.destroy
					if dest.present?
						self.rows.delete(row_id)
						self.save
						if self.present? && self.errors.blank?
							result = true
						end
					end
					
				end
			end
		end
		result
	end

	def rearrange_row(row_id, indx)
		result = nil
		rows = self.rows
		if is_row(rows, row_id)
			rows.delete(row_id)
			if indx < rows.length
				rows.insert(indx, row_id)
			else
				rows << row_id
			end
			self.rows = rows
			self.save
			result = self
		end
		result
	end

	def add_columns(columns)
		result = false
		cols = create_columns(columns)
		if cols.present?
			rows = TableRow.where(table: self)
			if rows.present?
				for row in rows 
					cells = row.create_new_cols(cols)
				end
				result = true
			end
		end
		result
	end

	def delete_column(col_id)
		result = false
		col = Column.find_by(id: col_id)
		if col.present?
			cells = Cell.where(column_id: col.id)
			dest = cells.destroy_all
			if dest.present?
				tab_cols = self.cols
				tab_cols.delete(col_id)
				self.cols = tab_cols
				self.save
				if self.present? && self.errors.blank?
					col.destroy
					if col.present? && col.errors.blank?
						result = true
					end
				end
			end
		else
		end
	end

	def rearrange_col(col_id, indx)
		result = nil
		cols = self.cols
		if is_col(cols, col_id)
			cols.delete(col_id)
			if indx < cols.length
				cols.insert(indx, col_id)
			else
				cols << col_id
			end
			self.cols = cols
			self.save
			result = self
		end
		result
	end

	def change_column_type(col_id, col_type)
		result = nil
		cols = self.cols
		if is_col(cols, col_type)
			col = Column.find_by(id: col_id)
			if col.present?
				col.col_type = col_type
				col.save
				if col.present? && col.errors.blank?
					cells = Cell.where(column_id: col.id)
					if cells.present?
						cells.each do |cell|
							cell.content = nil
							cell.save
						end
						result = true
					end
				end
			end
		end
		result
	end

	private

	def validate_columns(tab_cols, inc_cols)
		result = false
		if tab_cols.sort == inc_cols.sort
			result = true
		end
		result
	end

	def is_row(rows, row_id)
		rows.include? row_id
	end

	def is_col(cols, col_id)
		cols.include? col_id
	end
end