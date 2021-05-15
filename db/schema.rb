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

ActiveRecord::Schema.define(version: 2021_05_03_100254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "razorpay_orders", force: :cascade do |t|
    t.string "order_id", null: false
    t.integer "ss_subscription_plan"
    t.integer "pp_subscription_plan"
    t.string "user_name", null: false
    t.string "user_address", null: false
    t.string "user_city", null: false
    t.string "user_state", null: false
    t.string "user_pincode", null: false
    t.string "user_phone", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_razorpay_orders_on_order_id", unique: true
    t.index ["user_id"], name: "index_razorpay_orders_on_user_id"
    t.index ["user_name"], name: "index_razorpay_orders_on_user_name"
    t.index ["user_phone"], name: "index_razorpay_orders_on_user_phone"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone"
    t.string "email"
    t.string "name"
    t.string "otp"
    t.datetime "otp_created_at"
    t.datetime "session_expired_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

end
