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

ActiveRecord::Schema.define(version: 20161209133053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.integer  "user_id"
    t.bigint   "identifier"
    t.string   "text"
    t.string   "author"
    t.string   "author_image"
    t.datetime "added_at"
    t.text     "notes"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "timeline",     default: false
    t.boolean  "favorite",     default: false
    t.index ["added_at"], name: "index_tweets_on_added_at", using: :btree
    t.index ["author"], name: "index_tweets_on_author", using: :btree
    t.index ["favorite"], name: "index_tweets_on_favorite", using: :btree
    t.index ["identifier"], name: "index_tweets_on_identifier", using: :btree
    t.index ["text"], name: "index_tweets_on_text", using: :btree
    t.index ["timeline"], name: "index_tweets_on_timeline", using: :btree
    t.index ["user_id"], name: "index_tweets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "nickname"
    t.string   "name"
    t.string   "avatar"
    t.string   "url"
    t.string   "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

  add_foreign_key "tweets", "users"
end
