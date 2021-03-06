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

ActiveRecord::Schema.define(version: 20140627144118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "free_spots", force: true do |t|
    t.integer "start_day"
    t.integer "start_hour"
    t.integer "end_day"
    t.integer "end_hour"
    t.boolean "repetitive"
    t.integer "user_id"
    t.integer "start_minute"
    t.integer "end_minute"
  end

  add_index "free_spots", ["user_id"], name: "index_free_spots_on_user_id", using: :btree

  create_table "productions", force: true do |t|
    t.integer  "start_day"
    t.integer  "start_hour"
    t.integer  "end_day"
    t.integer  "end_hour"
    t.boolean  "repetitive"
    t.boolean  "cancelled",         default: false
    t.boolean  "confirmed_by_user"
    t.integer  "user_id"
    t.integer  "start_minute"
    t.integer  "end_minute"
    t.datetime "assigned_date"
    t.boolean  "reminded",          default: false
  end

  add_index "productions", ["user_id"], name: "index_productions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "email",              default: "",    null: false
    t.string   "encrypted_password", default: "",    null: false
    t.boolean  "admin",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
