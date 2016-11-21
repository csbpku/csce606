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

ActiveRecord::Schema.define(version: 20161115194428) do

  create_table "bikes", force: :cascade do |t|
    t.string  "typeofrack"
    t.integer "typeQuantity"
    t.integer "total_Capacity"
    t.float   "lat"
    t.float   "lon"
  end

  create_table "buildings", force: :cascade do |t|
    t.integer "number"
    t.string  "abbr"
    t.string  "name"
    t.string  "address"
    t.integer "numberoffloors"
    t.float   "lat"
    t.float   "lon"
  end

  create_table "calendar_dates", force: :cascade do |t|
    t.date    "date"
    t.integer "exception_type"
    t.integer "calendar_id"
    t.index ["calendar_id"], name: "index_calendar_dates_on_calendar_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.integer "monday"
    t.integer "tuesday"
    t.integer "wednesday"
    t.integer "thursday"
    t.integer "friday"
    t.integer "saturday"
    t.integer "sunday"
    t.date    "start_date"
    t.date    "end_date"
  end

  create_table "cars", force: :cascade do |t|
    t.string "lotname"
    t.string "lottype"
    t.float  "lat"
    t.float  "lon"
  end

  create_table "points", force: :cascade do |t|
    t.integer "shape_id"
    t.float   "pt_lan"
    t.float   "pt_lon"
    t.integer "pt_sequence"
    t.float   "shape_dist_traveled"
  end

  create_table "routes", force: :cascade do |t|
    t.string  "short_name"
    t.string  "long_name"
    t.text    "desc"
    t.integer "route_type"
    t.string  "color"
    t.string  "text_color"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "stop_times", force: :cascade do |t|
    t.time    "arrival_time"
    t.time    "departure_time"
    t.integer "stop_sequence"
    t.integer "pickup_type"
    t.integer "drop_off_type"
    t.float   "shape_dist_traveled"
    t.integer "stop_id"
    t.integer "trip_id"
    t.index ["stop_id"], name: "index_stop_times_on_stop_id"
    t.index ["trip_id"], name: "index_stop_times_on_trip_id"
  end

  create_table "stops", force: :cascade do |t|
    t.integer "code"
    t.string  "name"
    t.text    "desc"
    t.float   "lan"
    t.float   "lon"
    t.integer "location_type"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "headsign"
    t.integer "direction_id"
    t.string  "block_id"
    t.integer "route_id"
    t.integer "calendar_id"
    t.integer "shape_id"
    t.index ["calendar_id"], name: "index_trips_on_calendar_id"
    t.index ["route_id"], name: "index_trips_on_route_id"
  end

  create_table "walks", force: :cascade do |t|
  end

end
