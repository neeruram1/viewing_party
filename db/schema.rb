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


ActiveRecord::Schema.define(version: 2020_08_26_201933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "api_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.string "name"
  end

  create_table "view_parties", force: :cascade do |t|
    t.integer "duration"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "host_id"
    t.bigint "movie_id"
    t.index ["host_id"], name: "index_view_parties_on_host_id"
    t.index ["movie_id"], name: "index_view_parties_on_movie_id"
  end

  create_table "view_party_attendees", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "view_party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_view_party_attendees_on_user_id"
    t.index ["view_party_id"], name: "index_view_party_attendees_on_view_party_id"
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "view_parties", "movies"
  add_foreign_key "view_party_attendees", "users"
  add_foreign_key "view_party_attendees", "view_parties"
end
