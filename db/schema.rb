# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_10_165416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rates_histories", force: :cascade do |t|
    t.date "date", default: "2019-11-10"
    t.string "from_currency"
    t.string "to_currency"
    t.decimal "rate", precision: 12, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date", "from_currency", "to_currency"], name: "index_rates_histories_on_date_and_from_currency_and_to_currency", unique: true
  end

end
