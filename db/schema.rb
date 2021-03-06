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

ActiveRecord::Schema.define(version: 20150606135241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "user_id"
    t.boolean  "default",    default: false
    t.float    "ppr",        default: 0.0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "collections", ["default"], name: "index_collections_on_default", using: :btree
  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.string   "name",                                                null: false
    t.string   "position",                                            null: false
    t.string   "team"
    t.decimal  "points",        precision: 6, scale: 2, default: 0.0, null: false
    t.integer  "pos_rank",                              default: 0
    t.date     "birthdate"
    t.integer  "age"
    t.integer  "pass_comp",                             default: 0
    t.integer  "pass_att",                              default: 0
    t.integer  "pass_yards",                            default: 0
    t.integer  "pass_tds",                              default: 0
    t.integer  "pass_ints",                             default: 0
    t.integer  "rush_att",                              default: 0
    t.integer  "rush_yards",                            default: 0
    t.integer  "rush_tds",                              default: 0
    t.integer  "receptions",                            default: 0
    t.integer  "rec_yards",                             default: 0
    t.integer  "rec_tds",                               default: 0
    t.integer  "fum_lost",                              default: 0
    t.integer  "two_pt_conv",                           default: 0
    t.integer  "fum_rec_td",                            default: 0
    t.integer  "made_pat",                              default: 0
    t.integer  "miss_pat",                              default: 0
    t.integer  "made_under20",                          default: 0
    t.integer  "miss_under20",                          default: 0
    t.integer  "made20s",                               default: 0
    t.integer  "miss20s",                               default: 0
    t.integer  "made30s",                               default: 0
    t.integer  "miss30s",                               default: 0
    t.integer  "made40s",                               default: 0
    t.integer  "miss40s",                               default: 0
    t.integer  "made50_plus",                           default: 0
    t.integer  "miss50_plus",                           default: 0
    t.integer  "sacks",                                 default: 0
    t.integer  "interceptions",                         default: 0
    t.integer  "fum_rec",                               default: 0
    t.integer  "safeties",                              default: 0
    t.integer  "def_tds",                               default: 0
    t.integer  "return_tds",                            default: 0
    t.integer  "pts_allowed",                           default: 0
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "players", ["name"], name: "index_players_on_name", using: :btree
  add_index "players", ["position"], name: "index_players_on_position", using: :btree

  create_table "sheets", force: :cascade do |t|
    t.string   "position",      null: false
    t.integer  "collection_id"
    t.integer  "ranks",         null: false, array: true
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "sheets", ["collection_id"], name: "index_sheets_on_collection_id", using: :btree
  add_index "sheets", ["position", "collection_id"], name: "index_sheets_on_position_and_collection_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.boolean  "sleeper",    default: false
    t.boolean  "bust",       default: false
    t.boolean  "injury",     default: false
    t.boolean  "removed",    default: false
    t.text     "notes"
    t.integer  "sheet_id"
    t.integer  "player_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "tags", ["player_id"], name: "index_tags_on_player_id", using: :btree
  add_index "tags", ["sheet_id"], name: "index_tags_on_sheet_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",                               null: false
    t.string   "uid",                    default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "email"
    t.text     "tokens"
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["current_sign_in_at"], name: "index_users_on_current_sign_in_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "collections", "users"
  add_foreign_key "sheets", "collections"
  add_foreign_key "tags", "players"
  add_foreign_key "tags", "sheets"
end
