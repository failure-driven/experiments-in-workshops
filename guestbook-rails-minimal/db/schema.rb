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

ActiveRecord::Schema[7.1].define(version: 2025_03_30_115524) do
  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.string "name"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "generate_ai_text", default: false, null: false
    t.string "generated_text"
    t.boolean "use_generated_text", default: false, null: false
    t.string "generate_job_id"
  end

  create_table "generated_guestbook_entries", force: :cascade do |t|
    t.text "body"
    t.integer "guestbook_entry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guestbook_entry_id"], name: "index_generated_guestbook_entries_on_guestbook_entry_id", unique: true
  end

  create_table "guestbook_entries", force: :cascade do |t|
    t.text "body"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "generated_text"
  end

  add_foreign_key "generated_guestbook_entries", "guestbook_entries"
end
