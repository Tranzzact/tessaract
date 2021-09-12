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

ActiveRecord::Schema.define(version: 2021_09_12_101544) do

  create_table "stock_exchanges", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "mic"
    t.string "country"
    t.string "country_code"
    t.string "city"
    t.string "website"
    t.string "timezone"
    t.string "timezone_abbr"
    t.string "currency_code"
    t.string "currency_symbol"
    t.string "currency_name"
    t.string "service_api"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "has_intraday"
    t.string "has_eod"
    t.string "country"
    t.bigint "stock_exchange_id"
    t.string "service_api"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_exchange_id"], name: "index_tickers_on_stock_exchange_id"
  end

end
