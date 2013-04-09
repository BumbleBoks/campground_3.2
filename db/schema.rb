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

ActiveRecord::Schema.define(:version => 20130407190421) do

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
