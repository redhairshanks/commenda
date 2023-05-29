Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  scope :api do 
    post '/table/create', to: 'table#create_table'

    
    post '/table/:table_id/row/add', to: 'table#add_row'
    post '/table/:table_id/row/:row_id/delete', to: 'table#delete_row'
    post '/table/:table_id/row/:row_id/rearrange/:index', to: 'table#rearrange_row'
    get  '/table/:table_id/row/all', to: 'table#get_all_rows'
    

    post '/table/:table_id/columns/add', to: 'table#add_columns'
    post '/table/:table_id/column/:column_id/delete', to: 'table#delete_column'
    post '/table/:table_id/column/:column_id/rearrange/:index', to: 'table#rearrange_column'
    post '/table/:table_id/column/:column_id/change/:type', to: 'table#change_column_type'

    post '/table/:table_id/cell/:cell_id/edit', to: 'table#edit_cell'
  end

  
end
