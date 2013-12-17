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

ActiveRecord::Schema.define(:version => 20131216063552) do

  create_table "addresses", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "role"
  end

  create_table "car_pool_users", :force => true do |t|
    t.integer  "car_pool_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "car_pool_users", ["car_pool_id", "user_id"], :name => "index_car_pool_users_on_car_pool_id_and_user_id", :unique => true
  add_index "car_pool_users", ["car_pool_id"], :name => "index_car_pool_users_on_car_pool_id"
  add_index "car_pool_users", ["user_id"], :name => "index_car_pool_users_on_user_id"

  create_table "car_pools", :force => true do |t|
    t.string   "name"
    t.integer  "number_of_member"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "member_limit"
    t.integer  "school_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "father_name"
    t.string   "mother_name"
    t.integer  "father_contact_number"
    t.integer  "mother_contact_number"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "student_id"
    t.integer  "car_pool_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.integer  "address_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "stardard"
    t.integer  "user_id"
    t.integer  "school_id"
    t.integer  "car_pool_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.integer  "address_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
