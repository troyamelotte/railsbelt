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

ActiveRecord::Schema.define(version: 20161020194123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borrowers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "project"
    t.text     "desc"
    t.integer  "ammount_needed"
    t.integer  "ammount_raised"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "lenders", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "money"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "lendings", force: :cascade do |t|
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.integer  "ammount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lendings", ["borrower_id"], name: "index_lendings_on_borrower_id", using: :btree
  add_index "lendings", ["lender_id"], name: "index_lendings_on_lender_id", using: :btree

  add_foreign_key "lendings", "borrowers"
  add_foreign_key "lendings", "lenders"
end
