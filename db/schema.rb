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

ActiveRecord::Schema.define(:version => 20130521232942) do

  create_table "friends", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.integer  "facebook_id", :limit => 8, :null => false
    t.string   "gender",                   :null => false
    t.string   "first_name",               :null => false
    t.string   "last_name",                :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "fb_pic_url"
  end

  add_index "friends", ["facebook_id"], :name => "index_friends_on_facebook_id"

  create_table "love_interests", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "love_facebook_id", :limit => 8, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "love_interests", ["user_id", "love_facebook_id"], :name => "index_love_interests_on_user_id_and_love_facebook_id", :unique => true

  create_table "matches", :force => true do |t|
    t.integer  "first_user_id",                   :null => false
    t.integer  "second_user_id",                  :null => false
    t.string   "email_sent",     :default => "n", :null => false
    t.datetime "match_date",                      :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",                  :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.integer  "facebook_id",            :limit => 8
    t.string   "gender"
    t.string   "interested_in"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "time_zone"
    t.string   "locale"
    t.string   "location"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
