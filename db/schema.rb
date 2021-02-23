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

ActiveRecord::Schema.define(version: 0) do

  create_table "appcounter", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 100, null: false
    t.integer "value", null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["name"], name: "CounterName_UNIQUE", unique: true
  end

  create_table "driver", primary_key: ["id", "driverCode"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "driverCode", limit: 20, null: false
    t.string "firstName", limit: 100, null: false
    t.string "middleName", limit: 50, null: false
    t.string "lastName", limit: 100, null: false
    t.string "mobileNumber", limit: 45, null: false
    t.string "otherContactNumber", limit: 45
    t.string "emailAddress", limit: 100, null: false
    t.string "addressLine1", limit: 100, null: false
    t.string "addressLine2", limit: 100
    t.integer "addressBarangay", null: false
    t.string "addressBarangayName", limit: 50
    t.integer "addressLotNumber", null: false
    t.integer "addressZipCode", null: false
    t.string "addressStreetName", limit: 60, null: false
    t.string "addressDistrictName", limit: 60
    t.string "addressCityName", limit: 60, null: false
    t.string "driverPassword", limit: 60, null: false
    t.string "status", limit: 1, null: false
    t.index ["driverCode"], name: "driverCode_UNIQUE", unique: true
    t.index ["emailAddress"], name: "emailAddress_UNIQUE", unique: true
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["mobileNumber"], name: "mobileNumber_UNIQUE", unique: true
  end

  create_table "person", primary_key: ["id", "personCode"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "personCode", limit: 20, null: false
    t.string "firstName", limit: 100, null: false
    t.string "middleName", limit: 50, null: false
    t.string "lastName", limit: 100, null: false
    t.string "mobileNumber", limit: 45, null: false
    t.string "otherContactNumber", limit: 45
    t.string "emailAddress", limit: 100, null: false
    t.string "addressLine1", limit: 100, null: false
    t.string "addressLine2", limit: 100
    t.integer "addressBarangay", null: false
    t.string "addressBarangayName", limit: 50
    t.integer "addressLotNumber", null: false
    t.integer "addressZipCode", null: false
    t.string "addressStreetName", limit: 60, null: false
    t.string "addressDistrictName", limit: 60
    t.string "addressCityName", limit: 60, null: false
    t.string "personPassword", limit: 60, null: false
    t.string "status", limit: 1, null: false
    t.index ["emailAddress"], name: "emailAddress_UNIQUE", unique: true
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["mobileNumber"], name: "mobileNumber_UNIQUE", unique: true
    t.index ["personCode"], name: "personCode_UNIQUE", unique: true
  end

  create_table "reservation", primary_key: ["id", "reservationCode"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "reservationCode", limit: 20, null: false
    t.string "driverCode", limit: 45, null: false
    t.string "bookingDate", limit: 45, null: false
    t.datetime "estimatedTripDate", null: false
    t.string "personDestination", limit: 100, null: false
    t.string "personOrigin", limit: 100, null: false
    t.string "status", limit: 20, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["reservationCode"], name: "bookingCode_UNIQUE", unique: true
  end

  create_table "systemuser", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "userCode", limit: 20, null: false
    t.string "userName", limit: 50, null: false
    t.string "userEmail", limit: 100, null: false
    t.string "passWord", limit: 100, null: false
    t.string "contactNumber", limit: 45, null: false
    t.index ["contactNumber"], name: "contactNumber_UNIQUE", unique: true
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["userCode"], name: "userCode_UNIQUE", unique: true
    t.index ["userEmail"], name: "userEmail_UNIQUE", unique: true
    t.index ["userName"], name: "userName_UNIQUE", unique: true
  end

  create_table "trip", primary_key: ["id", "tripId"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "tripId", limit: 20, null: false
    t.string "pointOneEstimatedArrival", limit: 45
    t.string "pointTwoEstimatedArrival", limit: 45
    t.string "status", limit: 45
    t.string "personOrigin", limit: 45
    t.string "personDestination", limit: 45
    t.datetime "tripStartDate"
    t.datetime "tripEndDate"
    t.decimal "tripRating", precision: 10
    t.text "tripComment", limit: 4294967295
    t.string "reservationCode", limit: 20
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["tripId"], name: "tripId_UNIQUE", unique: true
  end

  create_table "vehicle", primary_key: ["id", "vehicleCode"], force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "id", null: false
    t.string "vehicleCode", limit: 20, null: false
    t.string "plateNumber", limit: 45, null: false
    t.string "vehicleType", limit: 50, null: false, comment: "need to set types of vehicle"
    t.string "registrationNumber", limit: 100, null: false, comment: "certificate of registration (CR)"
    t.string "vehicleModel", limit: 100, null: false
    t.integer "seatingCapacity", null: false
    t.integer "seatingOccupied"
    t.string "status", limit: 20
    t.datetime "updateDate"
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["vehicleCode"], name: "vehicleCode_UNIQUE", unique: true
  end

  create_table "vehicleassignment", id: :integer, default: nil, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "assignedAt", null: false
    t.string "assignedBy", limit: 45, null: false
    t.string "status", limit: 1, null: false
    t.datetime "updateDate", null: false
    t.string "updateBy", limit: 45, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

end
