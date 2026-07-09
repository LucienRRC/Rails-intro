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

ActiveRecord::Schema[7.2].define(version: 2026_07_09_013827) do
  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.string "country", null: false
    t.decimal "latitude", precision: 10, scale: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6, null: false
    t.string "timezone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "country"], name: "index_cities_on_name_and_country", unique: true
  end

  create_table "weather_records", force: :cascade do |t|
    t.integer "city_id", null: false
    t.date "recorded_on", null: false
    t.decimal "temperature_max", precision: 6, scale: 2
    t.decimal "temperature_min", precision: 6, scale: 2
    t.decimal "temperature_mean", precision: 6, scale: 2
    t.decimal "precipitation_sum", precision: 8, scale: 2
    t.decimal "wind_speed_max", precision: 6, scale: 2
    t.integer "weather_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id", "recorded_on"], name: "index_weather_records_on_city_id_and_recorded_on", unique: true
    t.index ["city_id"], name: "index_weather_records_on_city_id"
  end

  add_foreign_key "weather_records", "cities"
end
