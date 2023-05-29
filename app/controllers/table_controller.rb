class TableController < ApplicationController

	skip_before_action :verify_authenticity_token

	before_action :set_table, except: [:create_table]
	before_action :set_row, only: [:delete_row, :rearrange_row]
	before_action :set_column, only: [:delete_column, :rearrange_column, :change_column_type]

	def create_table
		if params[:name].present? && params[:columns].present? && 
			table = Table.create(params.permit(:name))
			if table.present? && table.errors.blank?
				columns = table.create_columns(params[:columns])
				if columns.present?
					success_handler({table: table, columns: columns}, nil)
				else
					error_handler({table: ["Unable to create columns"]}, :bad_request)
				end	
			else
				error_handler({table: table.error.messages}, :bad_request)
			end
		else
			error_handler({table: ["Missing params"]}, :bad_request)
		end	
	end

	def add_row
		row = @table.add_row(params[:columns])
		if row.present? && row.errors.blank?
			success_handler({row: row, cells: row.cells}, nil)
		else
			error_handler({row: ["Not created"]}, :bad_request)
		end
	end

	def delete_row
		del = @table.delete_row(params[:row_id])
		if del.present? 
			success_handler({row: ["Deleted"]}, nil)
		else
			error_handler({row: ["Not able to delete"]}, :bad_request)
		end
	end

	def rearrange_row
		rearr = @table.rearrange_row(params[:row_id], params[:index].to_i)
		if rearr.present? && rearr.errors.blank?
			success_handler({row: ["Rearranged"]}, nil)
		else
			error_handler({row: rearr.errors.messages}, :bad_request)
		end
	end


	def get_all_rows
		row_ids = @table.rows
		if row_ids.present?
			tab_rows = TableRow.where(id: row_ids)
			if tab_rows.present?
				result = []
				for row in tab_rows
					temp = {
						row_id: row.id,
						cells: row.cells
					}
					result << temp
				end
				success_handler({rows: result}, nil)
			else
				error_handler({rows: ["Not found"]}, :bad_request)
			end	
		else
			error_handler({rows: ["Not found"]}, :bad_request)
		end
	end

	def add_columns
		if params[:columns].present?
			add = @table.add_columns(params[:columns])
			if add.present?
				success_handler({columns: ["Added"]}, nil)
			else
				error_handler({columns: ["Not added"]}, :bad_request)
			end
		else
			error_handler({columns: ["Missing params"]}, :bad_request)
		end	
	end

	def delete_column
		col = @table.delete_column(params[:column_id])
		if col.present?
			success_handler({columns: ["Deleted"]}, nil)
		else
			error_handler({columns: ["Not deleted"]}, :bad_request)
		end
	end

	def rearrange_column
		rearr = @table.rearrange_col(params[:column_id], params[:index].to_i)
		if rearr.present? && rearr.errors.blank?
			success_handler({column: ["Rearranged"]}, nil)
		else
			error_handler({column: rearr.errors.messages}, :bad_request)
		end
	end

	def change_column_type
		col = @table.change_column_type(params[:column_id], params[:type])
		if col.present?
			success_handler({column: ["Type changed"]}, nil)
		else
			error_handler({column: ["Type not changed"]}, :bad_request)
		end
	end

	private 

	def set_table
		@table = Table.find_by(id: params[:table_id])
		if @table.blank?
			error_handler({table: ["Not found"]}, :bad_request)
		end
	end

	def set_row
		@row = TableRow.find_by(id: params[:row_id], table: @table)
		if @row.blank?
			error_handler({row: ["Not found"]}, :bad_request)
		end
	end

	def set_column
		@column = Column.find_by(id: params[:column_id])
		if @column.blank?
			error_handler({column: ["Not found"]}, :bad_request)
		end
	end

end
	