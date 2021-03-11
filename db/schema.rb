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

ActiveRecord::Schema.define(version: 20210228042205) do

  create_table "appcounter", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 100, null: false
    t.integer "value", null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["name"], name: "CounterName_UNIQUE", unique: true
  end

  create_table "enduser", primary_key: ["id", "end_user_code"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "end_user_code", limit: 20, null: false
    t.string "end_user_type", limit: 45
    t.string "first_name", limit: 200, null: false
    t.string "middle_name", limit: 200
    t.string "last_name", limit: 200, null: false
    t.string "contact_number", limit: 200
    t.string "mobile_number", limit: 200, null: false
    t.string "email", limit: 200
    t.string "password", limit: 200
    t.string "address_line1", limit: 200
    t.string "address_line2", limit: 200
    t.integer "barangay"
    t.string "barangay_name", limit: 45
    t.integer "lot_number"
    t.integer "zip_code"
    t.string "street_name", limit: 200
    t.string "district_name", limit: 200
    t.string "city_name", limit: 200
    t.string "status", limit: 1
    t.integer "password_reset_count"
    t.integer "password_invalid_count"
    t.index ["email"], name: "email_UNIQUE", unique: true
    t.index ["end_user_code"], name: "end_user_code_UNIQUE", unique: true
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["mobile_number"], name: "mobile_number_UNIQUE", unique: true
  end

  create_table "oauth_access_grants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id"
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "reservation", primary_key: ["id", "reservation_code"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "reservation_code", limit: 20, null: false
    t.string "end_user_code", limit: 45, null: false
    t.datetime "reservation_date", null: false
    t.datetime "estimated_trip_date", null: false
    t.string "destination", limit: 200, null: false
    t.string "origin", limit: 200, null: false
    t.string "status", limit: 20, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["reservation_code"], name: "bookingCode_UNIQUE", unique: true
  end

  create_table "role", primary_key: ["role_id", "role_code"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id", null: false
    t.string "role_code", limit: 20, null: false
    t.string "role_name", limit: 100, null: false
    t.integer "role_level", null: false
    t.datetime "create_date"
    t.string "created_by", limit: 45
    t.datetime "update_date"
    t.string "updated_by", limit: 45
    t.index ["role_code"], name: "appRoleCode_UNIQUE", unique: true
    t.index ["role_id"], name: "appRoleId_UNIQUE", unique: true
    t.index ["role_name"], name: "appRoleName_UNIQUE", unique: true
  end

  create_table "trip", primary_key: "trip_id", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "estimated_arrival_point_one"
    t.datetime "estimated_arrival_point_two"
    t.string "status", limit: 45
    t.string "origin", limit: 45
    t.string "destination", limit: 45
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "trip_rating", precision: 10
    t.text "remarks", limit: 4294967295
    t.string "reservation_code", limit: 20
    t.index ["trip_id"], name: "id_UNIQUE", unique: true
  end

  create_table "user", primary_key: ["user_id", "user_code"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.string "user_code", limit: 20, null: false
    t.string "username", limit: 50, null: false
    t.string "email", limit: 100, null: false
    t.string "contact_number", limit: 45, null: false
    t.string "password", limit: 200, null: false
    t.string "encrypted_password", limit: 200, null: false
    t.datetime "create_date"
    t.string "created_by", limit: 45
    t.datetime "update_date"
    t.string "updated_by", limit: 45
    t.integer "role_id"
    t.string "reset_password_token", limit: 200
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "userEmail_UNIQUE", unique: true
    t.index ["user_code"], name: "userCode_UNIQUE", unique: true
    t.index ["user_id"], name: "id_UNIQUE", unique: true
    t.index ["username"], name: "userName_UNIQUE", unique: true
  end

  create_table "vehicle", primary_key: ["id", "vehicle_code"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "vehicle_code", limit: 20, null: false
    t.string "vehicle_type", limit: 50, null: false, comment: "need to set types of vehicle"
    t.string "vehicle_model", limit: 100, null: false
    t.string "plate_number", limit: 45, null: false
    t.string "registration_number", limit: 100, null: false, comment: "certificate of registration (CR)"
    t.integer "seating_capacity", null: false
    t.integer "seating_occupied"
    t.string "status", limit: 20
    t.datetime "updateDate"
    t.string "end_user_code", limit: 20
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["vehicle_code"], name: "vehicleCode_UNIQUE", unique: true
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
