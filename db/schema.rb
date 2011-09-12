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

ActiveRecord::Schema.define(:version => 20110912214747) do

  create_table "canvae", :force => true do |t|
    t.string   "name"
    t.text     "mission"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.boolean  "open",       :default => true
  end

  create_table "canvas_user_roles", :force => true do |t|
    t.integer  "canvas_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.integer  "primary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "interested_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "canvas_id"
    t.integer  "creator_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "widget_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text_contents", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      :default => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "page_id"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "widgets", :force => true do |t|
    t.integer  "position"
    t.integer  "page_id"
    t.integer  "canvas_id"
    t.integer  "creator_id"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    t.integer  "parent_id"
    t.string   "alt_text"
    t.string   "image"
    t.string   "link"
    t.string   "title"
    t.text     "question"
    t.text     "answer"
  end

end
