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

ActiveRecord::Schema.define(:version => 20130330134740) do

  create_table "post_images", :force => true do |t|
    t.integer  "post_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "category_code"
    t.string   "title"
    t.string   "description"
    t.integer  "vote_count_1"
    t.integer  "vote_count_2"
    t.integer  "vote_count_3"
    t.integer  "vote_count_4"
    t.string   "rank"
    t.integer  "user_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "isBombed",            :default => false
    t.string   "photo1_file_name"
    t.string   "photo1_content_type"
    t.integer  "photo1_file_size"
    t.datetime "photo1_updated_at"
    t.string   "photo2_file_name"
    t.string   "photo2_content_type"
    t.integer  "photo2_file_size"
    t.datetime "photo2_updated_at"
    t.string   "photo3_file_name"
    t.string   "photo3_content_type"
    t.integer  "photo3_file_size"
    t.datetime "photo3_updated_at"
    t.string   "photo4_file_name"
    t.string   "photo4_content_type"
    t.integer  "photo4_file_size"
    t.datetime "photo4_updated_at"
  end

  add_index "posts", ["category_code"], :name => "index_posts_on_category_code"

  create_table "users", :force => true do |t|
    t.string   "fb_id",                                 :null => false
    t.string   "first_name",            :default => ""
    t.string   "last_name",             :default => ""
    t.string   "name",                  :default => ""
    t.string   "gender",                :default => ""
    t.string   "profile_url",           :default => ""
    t.string   "profile_thumbnail_url", :default => ""
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "users", ["fb_id"], :name => "index_users_on_fb_id", :unique => true

end
