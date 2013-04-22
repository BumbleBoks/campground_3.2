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

ActiveRecord::Schema.define(:version => 20130422042041) do

  create_table "common_activities", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "common_activities", ["name"], :name => "index_common_activities_on_name", :unique => true

  create_table "common_activity_associations", :force => true do |t|
    t.integer  "activity_id", :null => false
    t.integer  "trail_id",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "common_activity_associations", ["activity_id", "trail_id"], :name => "index_common_activity_associations_on_activity_id_and_trail_id", :unique => true
  add_index "common_activity_associations", ["activity_id"], :name => "index_common_activity_associations_on_activity_id"
  add_index "common_activity_associations", ["trail_id"], :name => "index_common_activity_associations_on_trail_id"

  create_table "common_states", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "common_states", ["name"], :name => "index_common_states_on_name", :unique => true

  create_table "common_trails", :force => true do |t|
    t.string   "name",        :limit => 75,                               :null => false
    t.decimal  "length",                    :precision => 5, :scale => 2
    t.text     "description"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.integer  "state_id"
  end

  add_index "common_trails", ["name"], :name => "index_common_trails_on_name"
  add_index "common_trails", ["state_id"], :name => "index_common_trails_on_state_id"

  create_table "community_updates", :force => true do |t|
    t.text     "content",    :null => false
    t.integer  "author_id",  :null => false
    t.integer  "trail_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "community_updates", ["author_id"], :name => "index_community_updates_on_author_id"
  add_index "community_updates", ["created_at"], :name => "index_community_updates_on_created_at"
  add_index "community_updates", ["trail_id"], :name => "index_community_updates_on_trail_id"

  create_table "corner_favorite_activities", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "activity_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "corner_favorite_activities", ["activity_id"], :name => "index_corner_favorite_activities_on_activity_id"
  add_index "corner_favorite_activities", ["user_id", "activity_id"], :name => "index_corner_favorite_activities_on_user_id_and_activity_id", :unique => true
  add_index "corner_favorite_activities", ["user_id"], :name => "index_corner_favorite_activities_on_user_id"

  create_table "corner_favorite_trails", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "trail_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "corner_favorite_trails", ["trail_id"], :name => "index_corner_favorite_trails_on_trail_id"
  add_index "corner_favorite_trails", ["user_id", "trail_id"], :name => "index_corner_favorite_trails_on_user_id_and_trail_id", :unique => true
  add_index "corner_favorite_trails", ["user_id"], :name => "index_corner_favorite_trails_on_user_id"

  create_table "site_tag_associations", :force => true do |t|
    t.integer  "tag_id",        :null => false
    t.integer  "associated_id", :null => false
    t.string   "type",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "site_tag_associations", ["associated_id", "type"], :name => "by_associated_item"
  add_index "site_tag_associations", ["tag_id", "associated_id", "type"], :name => "by_tag_in_associated_item", :unique => true
  add_index "site_tag_associations", ["tag_id"], :name => "index_site_tag_associations_on_tag_id"

  create_table "site_tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "site_tags", ["name"], :name => "index_site_tags_on_name", :unique => true

  create_table "site_user_requests", :force => true do |t|
    t.string   "email",        :null => false
    t.string   "token",        :null => false
    t.string   "request_type", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "site_user_requests", ["created_at"], :name => "index_site_user_requests_on_created_at"
  add_index "site_user_requests", ["email"], :name => "index_site_user_requests_on_email"
  add_index "site_user_requests", ["token"], :name => "index_site_user_requests_on_token"

  create_table "users", :force => true do |t|
    t.string   "login_id",        :limit => 50,                    :null => false
    t.string   "name",            :limit => 50,                    :null => false
    t.string   "email",                                            :null => false
    t.string   "password_digest",                                  :null => false
    t.boolean  "admin",                         :default => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "users", ["login_id"], :name => "index_users_on_login_id", :unique => true

end
