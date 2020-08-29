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

ActiveRecord::Schema.define(version: 2019_09_24_232206) do

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_components_on_organization_id"
  end

  create_table "components_incidents", id: false, force: :cascade do |t|
    t.integer "incident_id", null: false
    t.integer "component_id", null: false
  end

  create_table "components_subscribers", id: false, force: :cascade do |t|
    t.integer "subscriber_id", null: false
    t.integer "component_id", null: false
  end

  create_table "incidents", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_incidents_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organization_id"
    t.index ["organization_id"], name: "index_subscribers_on_organization_id"
  end

  add_foreign_key "components", "organizations"
  add_foreign_key "incidents", "organizations"
  add_foreign_key "subscribers", "organizations"
end
