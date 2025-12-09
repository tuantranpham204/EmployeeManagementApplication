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

ActiveRecord::Schema[8.1].define(version: 2025_12_09_093158) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "user_role", primary_key: ["user_id", "role_id"], force: :cascade do |t|
    t.serial "role_id", null: false
    t.serial "user_id", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.string "email", limit: 255, null: false
    t.string "username", limit: 255, null: false

    t.unique_constraint ["email"], name: "users_email_key"
  end

  add_foreign_key "user_role", "roles", name: "user_role_role_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user_role", "users", name: "user_role_user_id_fkey", on_update: :cascade, on_delete: :cascade
end
