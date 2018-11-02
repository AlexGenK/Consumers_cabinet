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

ActiveRecord::Schema.define(version: 2018_11_02_215007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumers", force: :cascade do |t|
    t.string "name"
    t.string "edrpou"
    t.string "dog_eh_num"
    t.date "dog_eh_date"
    t.string "dog_hoe_num"
    t.date "dog_hoe_date"
    t.integer "onec_id"
    t.string "user_email"
    t.string "manager_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "report_date"
  end

  create_table "counters", force: :cascade do |t|
    t.bigint "consumer_id"
    t.integer "number"
    t.integer "ratio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumer_id"], name: "index_counters_on_consumer_id"
  end

  create_table "powers", force: :cascade do |t|
    t.bigint "counter_id"
    t.date "measure_date"
    t.integer "active"
    t.integer "reactive"
    t.integer "generation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "before_active"
    t.integer "before_reactive"
    t.integer "before_generation"
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
    t.index ["consumer_id"], name: "index_previous_consumptions_on_consumer_id"
  end

  add_foreign_key "previous_consumptions", "consumers"
end
