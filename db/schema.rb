# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_20_210336) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_produce", force: :cascade do |t|
    t.bigint "produce_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_categories_produce_on_category_id"
    t.index ["produce_id"], name: "index_categories_produce_on_produce_id"
  end

  create_table "communities", force: :cascade do |t|
    t.bigint "region_id", null: false
    t.bigint "produce_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["produce_id"], name: "index_communities_on_produce_id"
    t.index ["region_id"], name: "index_communities_on_region_id"
  end

  create_table "email_bans", force: :cascade do |t|
    t.string "email"
    t.datetime "banned_until"
    t.text "reason"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_email_bans_on_user_id"
  end

  create_table "garden_varieties", force: :cascade do |t|
    t.bigint "garden_id", null: false
    t.bigint "variety_id", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["garden_id"], name: "index_garden_varieties_on_garden_id"
    t.index ["variety_id"], name: "index_garden_varieties_on_variety_id"
  end

  create_table "gardens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "score", default: 0, null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "longitude", null: false
    t.float "latitude", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.bigint "garden_variety_id", null: false
    t.integer "quantity", default: 0
    t.string "unit", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["garden_variety_id"], name: "index_markets_on_garden_variety_id"
  end

  create_table "produce", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_regions_on_location_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "roles_users", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.integer "score", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "language", default: "en", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "varieties", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "produce_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["produce_id"], name: "index_varieties_on_produce_id"
  end

  create_table "visitor_emails", force: :cascade do |t|
    t.string "email", null: false
    t.bigint "visitor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visitor_id"], name: "index_visitor_emails_on_visitor_id"
  end

  create_table "visitor_locations", force: :cascade do |t|
    t.float "longitude", null: false
    t.float "latitude", null: false
    t.bigint "visitor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["visitor_id"], name: "index_visitor_locations_on_visitor_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.inet "IP", null: false
    t.integer "request_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "categories_produce", "categories"
  add_foreign_key "categories_produce", "produce"
  add_foreign_key "communities", "produce"
  add_foreign_key "communities", "regions"
  add_foreign_key "email_bans", "users"
  add_foreign_key "garden_varieties", "gardens"
  add_foreign_key "garden_varieties", "varieties"
  add_foreign_key "gardens", "users"
  add_foreign_key "markets", "garden_varieties"
  add_foreign_key "regions", "locations"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "varieties", "produce"
  add_foreign_key "visitor_emails", "visitors"
  add_foreign_key "visitor_locations", "visitors"
end
