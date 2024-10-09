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

ActiveRecord::Schema[7.2].define(version: 2024_10_03_054911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "article_image", null: false
    t.text "caption"
    t.bigint "user_id"
    t.integer "is_public", default: 0, null: false
    t.integer "is_winner", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "topic_id"
    t.index ["topic_id"], name: "index_articles_on_topic_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "team_leaders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_leaders_on_team_id"
    t.index ["user_id"], name: "index_team_leaders_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "max_members", default: 10, null: false
    t.text "topic_order", null: false
    t.integer "topic_frequency", null: false
    t.time "topic_post_time", null: false
    t.datetime "topic_post_time_manual"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.index ["team_id"], name: "index_topics_on_team_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "nickname", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.integer "gender"
    t.text "bio"
    t.string "avatar"
    t.bigint "team_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "articles", "topics"
  add_foreign_key "articles", "users"
  add_foreign_key "team_leaders", "teams"
  add_foreign_key "team_leaders", "users"
  add_foreign_key "topics", "teams"
  add_foreign_key "topics", "users"
  add_foreign_key "users", "teams"
end
