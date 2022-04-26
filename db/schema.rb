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

ActiveRecord::Schema[7.0].define(version: 2022_04_26_103024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "description"
    t.bigint "idea_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_comments_on_idea_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dislikes", force: :cascade do |t|
    t.bigint "idea_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_dislikes_on_idea_id"
    t.index ["user_id"], name: "index_dislikes_on_user_id"
  end

  create_table "ideas", force: :cascade do |t|
    t.string "name"
    t.integer "access", default: 1, null: false
    t.text "description"
    t.string "sphere"
    t.string "location"
    t.text "plans"
    t.string "problem"
    t.string "necessary"
    t.json "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ideas_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "idea_id", null: false
    t.index ["idea_id"], name: "index_ideas_users_on_idea_id"
    t.index ["user_id"], name: "index_ideas_users_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "idea_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_likes_on_idea_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.float "mark"
    t.integer "amount"
    t.bigint "idea_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idea_id"], name: "index_rates_on_idea_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "skype"
    t.string "telephone"
    t.integer "role", default: 1
    t.string "avatar"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "ideas"
  add_foreign_key "comments", "users"
  add_foreign_key "dislikes", "ideas"
  add_foreign_key "dislikes", "users"
  add_foreign_key "likes", "ideas"
  add_foreign_key "likes", "users"
  add_foreign_key "rates", "ideas"
  add_foreign_key "rates", "users"
end