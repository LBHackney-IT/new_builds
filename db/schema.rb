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

ActiveRecord::Schema.define(version: 2018_07_31_132055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string "urn"
    t.bigint "user_id"
    t.bigint "scheme_id"
    t.bigint "scheme_priority_id"
    t.bigint "resident_id"
    t.bigint "location_id"
    t.text "description"
    t.string "trade"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_issues_on_location_id"
    t.index ["resident_id"], name: "index_issues_on_resident_id"
    t.index ["scheme_id"], name: "index_issues_on_scheme_id"
    t.index ["scheme_priority_id"], name: "index_issues_on_scheme_priority_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "location_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "location_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "location_desc_idx"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.bigint "scheme_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scheme_id"], name: "index_locations_on_scheme_id"
  end

  create_table "residents", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.integer "dwelling_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scheme_priorities", force: :cascade do |t|
    t.string "name"
    t.integer "duration_in_hours"
    t.bigint "scheme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scheme_id"], name: "index_scheme_priorities_on_scheme_id"
  end

  create_table "schemes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "issues", "locations"
  add_foreign_key "issues", "residents"
  add_foreign_key "issues", "scheme_priorities"
  add_foreign_key "issues", "schemes"
  add_foreign_key "issues", "users"
  add_foreign_key "locations", "schemes"
  add_foreign_key "scheme_priorities", "schemes"
end
