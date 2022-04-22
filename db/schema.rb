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

ActiveRecord::Schema.define(version: 2022_04_22_183147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bugs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "qa_id"
    t.bigint "developer_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_bugs_on_developer_id"
    t.index ["project_id"], name: "index_bugs_on_project_id"
    t.index ["qa_id"], name: "index_bugs_on_qa_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_projects_on_manager_id"
  end

  create_table "projects_developers", id: false, force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "developer_id"
    t.index ["developer_id"], name: "index_projects_developers_on_developer_id"
    t.index ["project_id"], name: "index_projects_developers_on_project_id"
  end

  create_table "projects_qas", id: false, force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "qa_id"
    t.index ["project_id"], name: "index_projects_qas_on_project_id"
    t.index ["qa_id"], name: "index_projects_qas_on_qa_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
