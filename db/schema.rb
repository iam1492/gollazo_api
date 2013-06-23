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

ActiveRecord::Schema.define(:version => 20130623145240) do

  create_table "comments", :force => true do |t|
    t.string   "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "imei",       :default => ""
  end

  create_table "items", :force => true do |t|
    t.text     "description"
    t.integer  "score"
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
    t.text     "description"
    t.integer  "vote_count_1",  :default => 0
    t.integer  "vote_count_2",  :default => 0
    t.integer  "vote_count_3",  :default => 0
    t.integer  "vote_count_4",  :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "isBombed",      :default => false
    t.string   "imei",          :default => ""
    t.integer  "item_count",    :default => 0
  end

  add_index "posts", ["category_code"], :name => "index_posts_on_category_code"

  create_table "selections", :force => true do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.string  "selected_items", :default => ""
  end

  create_table "users", :force => true do |t|
    t.string   "name",                  :default => ""
    t.string   "profile_url",           :default => ""
    t.string   "profile_thumbnail_url", :default => ""
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "imei",                  :default => ""
    t.string   "intro",                 :default => ""
    t.string   "profile_file_name"
    t.string   "profile_content_type"
    t.integer  "profile_file_size"
    t.datetime "profile_updated_at"
  end

  add_index "users", ["imei"], :name => "index_users_on_imei", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
