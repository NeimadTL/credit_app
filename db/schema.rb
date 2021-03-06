# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180310233534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_states", force: :cascade do |t|
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_tid"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "branch_code"
    t.string   "sort_code"
    t.string   "account_number"
    t.string   "rib_key"
    t.integer  "account_state_id"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "balance",          default: 0.0
  end

  create_table "monthly_salary_ranges", force: :cascade do |t|
    t.string   "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "range_tid"
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "role_tid"
    t.string   "role_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_states", force: :cascade do |t|
    t.integer  "state_tid"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "transaction_type"
    t.integer  "state_tid"
    t.integer  "bank_account_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "value",            default: 0.0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "", null: false
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "title"
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthday"
    t.string   "city"
    t.integer  "monthly_salary_range_id"
    t.string   "country"
    t.integer  "role_tid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
