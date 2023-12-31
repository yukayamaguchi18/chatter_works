# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_12_18_031459) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "chatter_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chatter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "chatter_id"], name: "index_chatter_favorites_on_user_id_and_chatter_id", unique: true
  end

  create_table "chatters", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "chatter_favorites_count", default: 0, null: false
    t.integer "rechatters_count", default: 0, null: false
    t.integer "reply_to_chatters_count", default: 0, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "work_id", null: false
    t.string "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_id", null: false
  end

  create_table "follow_requests", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_follow_requests_on_receiver_id"
    t.index ["sender_id", "receiver_id"], name: "index_follow_requests_on_sender_id_and_receiver_id", unique: true
    t.index ["sender_id"], name: "index_follow_requests_on_sender_id"
  end

  create_table "follow_tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "tag_id"], name: "index_follow_tags_on_user_id_and_tag_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "chatter_id"
    t.integer "reply_id"
    t.integer "work_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "is_checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rechatters", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chatter_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "chatter_id"], name: "index_rechatters_on_user_id_and_chatter_id", unique: true
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true
  end

  create_table "replies", force: :cascade do |t|
    t.integer "reply_id", null: false
    t.integer "reply_to_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "series", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "name"], name: "index_series_on_user_id_and_name", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "work_tags_count", default: 0, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.text "introduction", null: false
    t.boolean "is_public", default: true, null: false
    t.boolean "is_active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "chatters_count", default: 0, null: false
    t.integer "chatter_favorites_count", default: 0, null: false
    t.integer "works_count", default: 0, null: false
    t.integer "work_favorites_count", default: 0, null: false
    t.integer "followings_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "receiving_requests_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "work_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "work_id"], name: "index_work_favorites_on_user_id_and_work_id", unique: true
  end

  create_table "work_tags", force: :cascade do |t|
    t.integer "work_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag_id", null: false
    t.index ["work_id", "tag_id"], name: "index_work_tags_on_work_id_and_tag_id", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "caption", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "work_favorites_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "series_id"
    t.integer "public_status", default: 0, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "follow_requests", "users", column: "receiver_id"
  add_foreign_key "follow_requests", "users", column: "sender_id"
end
