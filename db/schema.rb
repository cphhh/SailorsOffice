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

ActiveRecord::Schema.define(version: 20190305181951) do

  create_table "balances", force: :cascade do |t|
    t.integer "regatta_id"
    t.boolean "closed"
    t.date "closing_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deposits", force: :cascade do |t|
    t.float "amount"
    t.date "date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "comment"
    t.integer "user_id"
    t.integer "regatta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regatta_users", force: :cascade do |t|
    t.integer "regatta_id", null: false
    t.integer "user_id", null: false
    t.float "balance"
    t.float "costs"
    t.float "fee"
    t.float "supplement"
    t.float "expenses"
    t.index ["regatta_id"], name: "index_regatta_users_on_regatta_id"
    t.index ["user_id"], name: "index_regatta_users_on_user_id"
  end

  create_table "regattas", force: :cascade do |t|
    t.string "name"
    t.string "place"
    t.date "startdate"
    t.date "enddate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "supplement"
    t.float "fee"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "slack_name"
  end

end
