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

ActiveRecord::Schema.define(version: 20180813200509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "type"
    t.decimal  "power"
    t.string   "description"
    t.string   "url"
    t.string   "address"
    t.float    "gps_lat"
    t.float    "gps_lng"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "aws_thing_name"
    t.index ["user_id"], name: "index_boxes_on_user_id", using: :btree
  end

  create_table "connectors", force: :cascade do |t|
    t.integer  "box_id"
    t.string   "aws_conn_id"
    t.string   "code"
    t.string   "url"
    t.decimal  "power"
    t.integer  "voltage"
    t.decimal  "i_max"
    t.decimal  "price_per_kWh"
    t.integer  "current_user"
    t.integer  "frequency"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.integer  "current_tnx"
    t.index ["box_id"], name: "index_connectors_on_box_id", using: :btree
  end

  create_table "el_sockets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "url"
    t.string   "address"
    t.float    "gps_lat"
    t.float    "gps_lng"
    t.integer  "voltage"
    t.integer  "i_limit"
    t.float    "price_per_kWh"
    t.integer  "current_user"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "frequency"
    t.integer  "status"
    t.string   "thing_name"
    t.index ["user_id"], name: "index_el_sockets_on_user_id", using: :btree
  end

  create_table "socket_loads", force: :cascade do |t|
    t.integer  "el_socket_id"
    t.datetime "time"
    t.float    "i1"
    t.float    "v1"
    t.float    "p1"
    t.float    "i2"
    t.float    "v2"
    t.float    "p2"
    t.float    "i3"
    t.float    "v3"
    t.float    "p3"
    t.float    "i_total"
    t.float    "v_avg"
    t.float    "p_total"
    t.index ["el_socket_id"], name: "index_socket_loads_on_el_socket_id", using: :btree
  end

  create_table "socket_usages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "el_socket_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float    "kWhs"
    t.float    "amount"
    t.date     "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "start_tag"
    t.string   "end_tag"
    t.index ["el_socket_id"], name: "index_socket_usages_on_el_socket_id", using: :btree
    t.index ["user_id"], name: "index_socket_usages_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "tag_type"
    t.string   "token"
    t.string   "pin"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uid"
    t.index ["user_id"], name: "index_tags_on_user_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "debtor_id"
    t.integer  "creditor_id"
    t.integer  "box_id"
    t.integer  "connector_id"
    t.decimal  "kWhs_used"
    t.decimal  "price_per_kWh"
    t.decimal  "amount"
    t.date     "date_posted"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "meter_Whs_start"
    t.integer  "meter_Whs_finish"
    t.integer  "tag_id_start"
    t.integer  "tag_id_finish"
    t.index ["box_id"], name: "index_transactions_on_box_id", using: :btree
    t.index ["connector_id"], name: "index_transactions_on_connector_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.integer  "last_usage"
    t.boolean  "is_approved"
    t.boolean  "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "boxes", "users"
  add_foreign_key "connectors", "boxes"
  add_foreign_key "el_sockets", "users"
  add_foreign_key "socket_loads", "el_sockets"
  add_foreign_key "socket_usages", "el_sockets"
  add_foreign_key "socket_usages", "users"
  add_foreign_key "tags", "users"
  add_foreign_key "transactions", "boxes"
  add_foreign_key "transactions", "connectors"
end
