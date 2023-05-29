class Cell < ApplicationRecord

	belongs_to :table_row
	belongs_to :column
end