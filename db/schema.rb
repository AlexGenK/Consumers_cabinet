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

ActiveRecord::Schema.define(version: 2020_06_01_175522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "certificates", force: :cascade do |t|
    t.bigint "consumer_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumer_id"], name: "index_certificates_on_consumer_id"
  end

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
    t.boolean "can_get_certificate", default: false
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
    t.boolean "count_out", default: false
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

  create_table "payments", force: :cascade do |t|
    t.string "company"
    t.integer "edrpou"
    t.string "account"
    t.string "bank"
    t.integer "mfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "services", force: :cascade do |t|
    t.text "last_cert_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "counters", "contracts"
  add_foreign_key "previous_consumptions", "consumers"
end
