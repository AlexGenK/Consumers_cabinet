# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_02_02_160323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumers", force: :cascade do |t|
    t.string "name"
    t.string "edrpou"
    t.string "dog_eh_num"
    t.date "dog_eh_date"
    t.integer "onec_id"
    t.string "client_username"
    t.string "manager_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_date"
    t.string "full_name"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "consumer_id"
    t.string "number"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumer_id"], name: "index_contracts_on_consumer_id"
  end

  create_table "counters", force: :cascade do |t|
    t.string "number"
    t.integer "ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account"
    t.bigint "contract_id"
    t.index ["contract_id"], name: "index_counters_on_contract_id"
  end

  create_table "current_consumptions", force: :cascade do |t|
    t.bigint "consumer_id"
    t.integer "power"
    t.float "tariff"
    t.float "money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "transferred", default: false
    t.index ["consumer_id"], name: "index_current_consumptions_on_consumer_id"
  end

  create_table "powers", force: :cascade do |t|
    t.bigint "counter_id"
    t.date "measure_date"
    t.decimal "active", precision: 10, scale: 3, default: "0.0"
    t.decimal "reactive", precision: 10, scale: 3, default: "0.0"
    t.decimal "generation", precision: 10, scale: 3, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "before_active", precision: 10, scale: 3, default: "0.0"
    t.decimal "before_reactive", precision: 10, scale: 3, default: "0.0"
    t.decimal "before_generation", precision: 10, scale: 3, default: "0.0"
    t.index ["counter_id"], name: "index_powers_on_counter_id"
  end

  create_table "previous_consumptions", force: :cascade do |t|
    t.date "date"
    t.integer "power"
    t.float "tariff"
    t.float "money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "consumer_id"
    t.integer "level", default: 0
    t.string "point_name"
    t.index ["consumer_id"], name: "index_previous_consumptions_on_consumer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_role", default: false
    t.boolean "manager_role", default: false
    t.boolean "client_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "counters", "contracts"
  add_foreign_key "previous_consumptions", "consumers"
end
