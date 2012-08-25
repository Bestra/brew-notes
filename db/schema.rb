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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120818191108) do

  create_table "fermentable_manifests", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "fermentable_id"
    t.float    "amount"
    t.string   "notes"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "fermentables", :force => true do |t|
    t.string   "name"
    t.integer  "ppg"
    t.float    "unit_price"
    t.string   "weight_unit"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hop_manifests", :force => true do |t|
    t.integer  "recipe_id"
    t.integer  "hop_id"
    t.float    "amount"
    t.integer  "boil_time"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "aau"
    t.float    "aa_percent"
  end

  create_table "hops", :force => true do |t|
    t.string   "name"
    t.float    "unit_price"
    t.string   "weight_unit"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
  end

  add_index "hops", ["name"], :name => "index_hops_on_name", :unique => true

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.integer  "style_id"
    t.integer  "user_id"
    t.integer  "ibu"
    t.float    "og"
    t.float    "fg"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "description"
    t.float    "final_volume"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
