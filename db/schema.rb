# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_29_145100) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cells", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "table_row_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "column_id"
    t.index ["column_id"], name: "index_cells_on_column_id"
    t.index ["table_row_id"], name: "index_cells_on_table_row_id"
  end

  create_table "columns", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "col_type"
    t.string "col_name"
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "table_rows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_table_rows_on_table_id"
  end

  create_table "tables", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "rows", default: [], array: true
    t.uuid "cols", default: [], array: true
  end

  add_foreign_key "cells", "columns"
  add_foreign_key "cells", "table_rows"
  add_foreign_key "columns", "tables"
  add_foreign_key "table_rows", "tables"
end
