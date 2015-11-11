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

ActiveRecord::Schema.define(version: 20151111152627) do

  create_table "attendee_form_questions", force: :cascade do |t|
    t.integer  "attendee_form_id", limit: 4
    t.integer  "q_type",           limit: 4
    t.string   "title",            limit: 255
    t.text     "selections",       limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "attendee_forms", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "cowork_code",  limit: 255
    t.string   "title",        limit: 255
    t.string   "city",         limit: 255
    t.string   "district",     limit: 255
    t.string   "address",      limit: 255
    t.string   "place_name",   limit: 255
    t.datetime "wedding_date"
    t.datetime "fill_start"
    t.datetime "fill_end"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "guest_groups", force: :cascade do |t|
    t.integer  "attendee_form_id", limit: 4
    t.string   "name",             limit: 255
    t.boolean  "is_bride"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "guest_replies", force: :cascade do |t|
    t.integer  "attendee_form_id",   limit: 4
    t.boolean  "is_attend"
    t.boolean  "is_need_invitation"
    t.integer  "guest_group_id",     limit: 4
    t.integer  "people_count",       limit: 4
    t.integer  "absent_type",        limit: 4
    t.string   "absent_reason",      limit: 255
    t.string   "zip_code",           limit: 255
    t.string   "city",               limit: 255
    t.string   "district",           limit: 255
    t.string   "address",            limit: 255
    t.text     "answer_json",        limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.boolean  "gender"
    t.string   "fb_link",                limit: 255
    t.datetime "birthday"
    t.datetime "locale"
    t.string   "timezone",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
