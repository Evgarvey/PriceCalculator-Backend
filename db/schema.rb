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

ActiveRecord::Schema[8.0].define(version: 2025_02_03_162713) do
  create_table "common_material_prices", force: :cascade do |t|
    t.integer "material_id", null: false
    t.decimal "price_per_m3"
    t.decimal "density"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_common_material_prices_on_material_id"
  end

  create_table "currency_prices", force: :cascade do |t|
    t.integer "material_id", null: false
    t.decimal "usd_ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_currency_prices_on_material_id"
  end

  create_table "liquid_prices", force: :cascade do |t|
    t.integer "material_id", null: false
    t.decimal "price_per_liter"
    t.decimal "density"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_liquid_prices_on_material_id"
  end

  create_table "list_items", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "material_id", null: false
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_items_on_list_id"
    t.index ["material_id"], name: "index_list_items_on_material_id"
  end

  create_table "material_categories", force: :cascade do |t|
    t.string "name"
    t.string "base_unit"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.integer "material_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_category_id"], name: "index_materials_on_material_category_id"
  end

  create_table "precious_material_prices", force: :cascade do |t|
    t.integer "material_id", null: false
    t.decimal "price_per_gram"
    t.decimal "density"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_precious_material_prices_on_material_id"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "common_material_prices", "materials"
  add_foreign_key "currency_prices", "materials"
  add_foreign_key "liquid_prices", "materials"
  add_foreign_key "list_items", "lists"
  add_foreign_key "list_items", "materials"
  add_foreign_key "materials", "material_categories"
  add_foreign_key "precious_material_prices", "materials"
  add_foreign_key "shopping_lists", "users"
end
