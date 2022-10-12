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

ActiveRecord::Schema[7.0].define(version: 2022_10_12_192421) do
  create_table "distance_price_tables", force: :cascade do |t|
    t.integer "transport_modality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_modality_id"], name: "index_distance_price_tables_on_transport_modality_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "sender_full_address"
    t.string "sender_zip_code"
    t.string "package_code"
    t.integer "package_height"
    t.integer "package_width"
    t.integer "package_depth"
    t.integer "package_weight"
    t.string "receiver_name"
    t.string "receiver_full_address"
    t.string "receiver_zip_code"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "table_entries", force: :cascade do |t|
    t.integer "first_interval"
    t.integer "second_interval"
    t.float "price"
    t.integer "distance_price_table_id"
    t.integer "weight_price_table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["distance_price_table_id"], name: "index_table_entries_on_distance_price_table_id"
    t.index ["weight_price_table_id"], name: "index_table_entries_on_weight_price_table_id"
  end

  create_table "transport_modalities", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.float "fee"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand_name"
    t.string "vehicle_type"
    t.string "fabrication_year"
    t.integer "maximum_capacity"
    t.integer "transport_modality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["transport_modality_id"], name: "index_vehicles_on_transport_modality_id"
  end

  create_table "weight_price_tables", force: :cascade do |t|
    t.integer "transport_modality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_modality_id"], name: "index_weight_price_tables_on_transport_modality_id"
  end

  add_foreign_key "distance_price_tables", "transport_modalities"
  add_foreign_key "table_entries", "distance_price_tables"
  add_foreign_key "table_entries", "weight_price_tables"
  add_foreign_key "weight_price_tables", "transport_modalities"
end
