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

ActiveRecord::Schema.define(version: 2020_03_06_195048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answer_votes", force: :cascade do |t|
    t.bigint "answer_id", null: false
    t.bigint "user_id", null: false
    t.integer "vote", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["answer_id"], name: "index_answer_votes_on_answer_id"
    t.index ["user_id"], name: "index_answer_votes_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.integer "score", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

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

  create_table "communities_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "community_id"
    t.index ["community_id"], name: "index_communities_users_on_community_id"
    t.index ["user_id"], name: "index_communities_users_on_user_id"
  end

  create_table "email_bans", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "banned_until", null: false
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
    t.bigint "location_id", null: false
    t.index ["location_id"], name: "index_gardens_on_location_id"
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "house_number"
    t.string "road"
    t.string "neighbourhood"
    t.string "suburb"
    t.string "county"
    t.string "additional_informations"
    t.string "city"
    t.string "province"
    t.string "region"
    t.string "country"
    t.string "country_code"
    t.string "postal_code"
  end

  create_table "market_notifications", force: :cascade do |t|
    t.string "email", null: false
    t.bigint "market_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "language"
    t.index ["market_id"], name: "index_market_notifications_on_market_id"
  end

  create_table "markets", force: :cascade do |t|
    t.bigint "garden_variety_id", null: false
    t.integer "quantity", default: 0
    t.string "unit", null: false
    t.boolean "is_active", default: true, null: false
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

  create_table "question_votes", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "user_id", null: false
    t.integer "vote", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_question_votes_on_question_id"
    t.index ["user_id"], name: "index_question_votes_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.integer "score", default: 0, null: false
    t.bigint "community_id", null: false
    t.bigint "selected_answer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.integer "answers_count", default: 0, null: false
    t.index ["community_id"], name: "index_questions_on_community_id"
    t.index ["selected_answer_id"], name: "index_questions_on_selected_answer_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "questions_tags", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "tag_id"
    t.index ["question_id"], name: "index_questions_tags_on_question_id"
    t.index ["tag_id"], name: "index_questions_tags_on_tag_id"
  end

  create_table "questions_varieties", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "variety_id"
    t.index ["question_id"], name: "index_questions_varieties_on_question_id"
    t.index ["variety_id"], name: "index_questions_varieties_on_variety_id"
  end

  create_table "regions", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_regions_on_location_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "reporter_email", null: false
    t.string "reported_email", null: false
    t.text "reason", null: false
    t.integer "status", default: 0, null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "community_id"
    t.index ["community_id"], name: "index_roles_on_community_id"
  end

  create_table "roles_users", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.integer "score", default: 0, null: false
  end

  create_table "user_messages", force: :cascade do |t|
    t.bigint "source_user_id", null: false
    t.bigint "recipient_user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_user_id"], name: "index_user_messages_on_recipient_user_id"
    t.index ["source_user_id"], name: "index_user_messages_on_source_user_id"
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

  create_table "visitor_messages", force: :cascade do |t|
    t.bigint "source_visitor_email_id", null: false
    t.bigint "recipient_user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_user_id"], name: "index_visitor_messages_on_recipient_user_id"
    t.index ["source_visitor_email_id"], name: "index_visitor_messages_on_source_visitor_email_id"
  end

  create_table "visitors", force: :cascade do |t|
    t.inet "IP", null: false
    t.integer "request_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answer_votes", "answers"
  add_foreign_key "answer_votes", "users"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "categories_produce", "categories"
  add_foreign_key "categories_produce", "produce"
  add_foreign_key "communities", "produce"
  add_foreign_key "communities", "regions"
  add_foreign_key "communities_users", "communities"
  add_foreign_key "communities_users", "users"
  add_foreign_key "email_bans", "users"
  add_foreign_key "garden_varieties", "gardens"
  add_foreign_key "garden_varieties", "varieties"
  add_foreign_key "gardens", "locations"
  add_foreign_key "gardens", "users"
  add_foreign_key "market_notifications", "markets"
  add_foreign_key "markets", "garden_varieties"
  add_foreign_key "question_votes", "questions"
  add_foreign_key "question_votes", "users"
  add_foreign_key "questions", "communities"
  add_foreign_key "questions", "users"
  add_foreign_key "regions", "locations"
  add_foreign_key "reports", "users"
  add_foreign_key "roles", "communities"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "user_messages", "users", column: "recipient_user_id"
  add_foreign_key "user_messages", "users", column: "source_user_id"
  add_foreign_key "varieties", "produce"
  add_foreign_key "visitor_emails", "visitors"
  add_foreign_key "visitor_locations", "visitors"
  add_foreign_key "visitor_messages", "users", column: "recipient_user_id"
  add_foreign_key "visitor_messages", "visitor_emails", column: "source_visitor_email_id"
end
