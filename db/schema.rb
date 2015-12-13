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

ActiveRecord::Schema.define(version: 20151011005108) do

  create_table "menu_items", force: :cascade do |t|
    t.string   "title",      default: ""
    t.string   "desc",       default: ""
    t.decimal  "price",      default: 0.0
    t.integer  "spice",      default: 0
    t.boolean  "veg",        default: false
    t.boolean  "healthy",    default: false
    t.integer  "menu_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id"

  create_table "menus", force: :cascade do |t|
    t.string   "desc",          default: ""
    t.integer  "menu_item_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "menus", ["restaurant_id"], name: "index_menus_on_restaurant_id"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       default: ""
    t.integer  "user_id"
    t.string   "address",    default: ""
    t.string   "city",       default: ""
    t.string   "postal",     default: ""
    t.string   "province",   default: ""
    t.string   "country",    default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurants", ["user_id"], name: "index_restaurants_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "auth_token",             default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
