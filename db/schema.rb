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

ActiveRecord::Schema.define(version: 20181015204052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "member_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "roleholder",         default: false
    t.string   "role_name"
    t.boolean  "can_manage_members", default: false
    t.boolean  "is_public",          default: false
    t.boolean  "can_manage_group",   default: false
    t.index ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
    t.index ["member_id"], name: "index_group_memberships_on_member_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.jsonb    "filter"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "description"
    t.string   "why_receiving"
    t.boolean  "automatic_update", default: true
    t.boolean  "joinable",         default: true
    t.boolean  "leavable",         default: true
  end

  create_table "mailouts", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "subject"
    t.text     "body"
    t.integer  "user_id"
    t.string   "from_email"
    t.string   "from_first_name"
    t.string   "from_last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "mailgun_id"
    t.index ["group_id"], name: "index_mailouts_on_group_id", using: :btree
    t.index ["user_id"], name: "index_mailouts_on_user_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "email_address"
    t.boolean   "email_opt_in"
    t.boolean   "is_volunteer"
    t.string    "phone"
    t.string    "mobile"
    t.boolean   "mobile_opt_in"
    t.string    "employer"
    t.string    "occupation"
    t.string    "facebook_id"
    t.string    "twitter_login"
    t.date      "born_at"
    t.datetime  "created_at",                                                                        null: false
    t.datetime  "updated_at",                                                                        null: false
    t.string    "address1"
    t.string    "address2"
    t.string    "city"
    t.string    "state"
    t.string    "country_code"
    t.string    "post_code"
    t.decimal   "lat"
    t.decimal   "lng"
    t.geography "lonlat",                limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer   "membership_id"
    t.datetime  "membership_started_at"
    t.string    "membership_level"
    t.string    "paypal_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "role"
    t.integer  "member_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["member_id"], name: "index_users_on_member_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "group_memberships", "groups"
  add_foreign_key "group_memberships", "members"
  add_foreign_key "mailouts", "groups"
  add_foreign_key "mailouts", "users"
  add_foreign_key "users", "members"
end
