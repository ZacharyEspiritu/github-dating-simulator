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

ActiveRecord::Schema.define(version: 20160925110850) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parties", force: :cascade do |t|
    t.string   "party_name"
    t.text     "usernames"
    t.text     "edit_key"
    t.boolean  "activated",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "results", force: :cascade do |t|
    t.string   "result_name"
    t.text     "data"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "practical",   default: false
    t.text     "percentages"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "user_data", force: :cascade do |t|
    t.string   "username"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "avatar_url"
  end

end
