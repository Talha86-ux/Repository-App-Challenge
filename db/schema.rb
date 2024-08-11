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

ActiveRecord::Schema.define(version: 2024_08_04_221709) do

  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "assign_users"
  end

  create_table "user_repositories", force: :cascade do |t|
    t.boolean "private", default: false
    t.integer "user_id"
    t.integer "repository_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repository_id"], name: "index_user_repositories_on_repository_id"
    t.index ["user_id", "repository_id"], name: "index_user_repositories_on_user_id_and_repository_id"
    t.index ["user_id"], name: "index_user_repositories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_token_sent_at"
  end

  add_foreign_key "user_repositories", "repositories"
  add_foreign_key "user_repositories", "users"
end
