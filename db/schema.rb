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

ActiveRecord::Schema.define(version: 20140204203140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "interview_history_items", force: true do |t|
    t.datetime "history_datetime", null: false
    t.integer  "position_id",      null: false
    t.integer  "interview_id",     null: false
    t.string   "message",          null: false
  end

  create_table "interviews", force: true do |t|
    t.datetime "interview_datetime"
    t.integer  "position_id"
    t.integer  "status_id",          null: false
    t.string   "email_key"
  end

  create_table "leaders", force: true do |t|
    t.string "name", null: false
  end

  create_table "positions", force: true do |t|
    t.string  "name",                    null: false
    t.integer "leader_id",               null: false
    t.integer "user_id",                 null: false
    t.string  "meeting_time", limit: 10
  end

  create_table "users", force: true do |t|
    t.string  "username",                         null: false
    t.string  "first_name",                       null: false
    t.string  "email",                            null: false
    t.string  "crypted_password",                 null: false
    t.string  "salt",                             null: false
    t.string  "last_name",                        null: false
    t.string  "honorific",                        null: false
    t.string  "phone_number",                     null: false
    t.boolean "admin",            default: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
