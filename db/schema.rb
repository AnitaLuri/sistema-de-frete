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

ActiveRecord::Schema[7.0].define(version: 2022_10_17_182413) do
  create_table "deadlines", force: :cascade do |t|
    t.integer "start"
    t.integer "limit"
    t.integer "time"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_deadlines_on_transport_mode_id"
  end

  create_table "distance_prices", force: :cascade do |t|
    t.integer "initial_distance"
    t.integer "ending_distance"
    t.decimal "price"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_distance_prices_on_transport_mode_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.string "code"
    t.string "from"
    t.string "to"
    t.integer "distance"
    t.string "product_code"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.integer "weight"
    t.string "recipient"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transport_mode_id"
    t.index ["transport_mode_id"], name: "index_service_orders_on_transport_mode_id"
  end

  create_table "started_orders", force: :cascade do |t|
    t.integer "service_order_id", null: false
    t.integer "transport_mode_id", null: false
    t.decimal "total_value"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
    t.integer "delivery_time"
    t.date "delivery_day"
    t.string "comment"
    t.date "created_day"
    t.index ["service_order_id"], name: "index_started_orders_on_service_order_id"
    t.index ["transport_mode_id"], name: "index_started_orders_on_transport_mode_id"
    t.index ["vehicle_id"], name: "index_started_orders_on_vehicle_id"
  end

  create_table "transport_modes", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.integer "fixed_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "profile", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "brand"
    t.string "model"
    t.integer "year"
    t.integer "weight_limit"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["transport_mode_id"], name: "index_vehicles_on_transport_mode_id"
  end

  create_table "weight_prices", force: :cascade do |t|
    t.integer "initial_weight"
    t.integer "ending_weight"
    t.decimal "km_value"
    t.integer "transport_mode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transport_mode_id"], name: "index_weight_prices_on_transport_mode_id"
  end

  add_foreign_key "deadlines", "transport_modes"
  add_foreign_key "distance_prices", "transport_modes"
  add_foreign_key "service_orders", "transport_modes"
  add_foreign_key "started_orders", "service_orders"
  add_foreign_key "started_orders", "transport_modes"
  add_foreign_key "started_orders", "vehicles"
  add_foreign_key "vehicles", "transport_modes"
  add_foreign_key "weight_prices", "transport_modes"
end
