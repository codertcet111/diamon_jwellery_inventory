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

ActiveRecord::Schema.define(version: 2020_12_12_135145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brokers", force: :cascade do |t|
    t.string "name", null: false
    t.string "mobile", null: false
    t.string "qbc"
    t.text "address"
    t.string "reference_1"
    t.string "reference_2"
    t.string "reference_3"
    t.string "gst_no"
    t.string "pan_no"
    t.string "adhaar_no"
    t.string "mobile_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "expense_type", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_id", null: false
    t.float "weight_loss"
    t.index ["stock_id"], name: "index_expenses_on_stock_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name", null: false
    t.string "mobile", null: false
    t.string "qbc"
    t.text "address", null: false
    t.string "reference_1"
    t.string "reference_2"
    t.string "reference_3"
    t.string "gst_no", null: false
    t.string "pan_no", null: false
    t.string "adhaar_no"
    t.string "mobile_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_mode", null: false
    t.datetime "date", null: false
    t.decimal "amount", precision: 15, scale: 4, null: false
    t.text "notes"
    t.string "party_come"
    t.string "pc_acc_name"
    t.string "party_paid"
    t.string "pp_acc_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "party_id", null: false
    t.bigint "purchase_id", null: false
    t.index ["party_id"], name: "index_payments_on_party_id"
    t.index ["purchase_id"], name: "index_payments_on_purchase_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.datetime "purchase_date", null: false
    t.integer "terms", null: false
    t.float "dollar_rate", null: false
    t.boolean "bill_present", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "party_id", null: false
    t.bigint "broker_id"
    t.decimal "pending_amount", precision: 15, scale: 4, default: "0.0"
    t.index ["broker_id"], name: "index_purchases_on_broker_id"
    t.index ["party_id"], name: "index_purchases_on_party_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.integer "receipt_mode", null: false
    t.datetime "date", null: false
    t.decimal "amount", null: false
    t.text "notes"
    t.string "party_come"
    t.string "pc_acc_name"
    t.string "party_paid"
    t.string "pp_acc_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "party_id", null: false
    t.bigint "sale_id", null: false
    t.index ["party_id"], name: "index_receipts_on_party_id"
    t.index ["sale_id"], name: "index_receipts_on_sale_id"
  end

  create_table "sale_items", force: :cascade do |t|
    t.integer "shape", null: false
    t.integer "color", null: false
    t.integer "clarity", null: false
    t.float "carat", null: false
    t.float "weight", null: false
    t.float "rap", null: false
    t.float "discount_percentage"
    t.float "additional_disc_1"
    t.float "additional_disc_2"
    t.float "additional_disc_3"
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_id", null: false
    t.bigint "sale_id", null: false
    t.index ["sale_id"], name: "index_sale_items_on_sale_id"
    t.index ["stock_id"], name: "index_sale_items_on_stock_id"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "sale_date", null: false
    t.integer "terms", null: false
    t.float "broker_percentage"
    t.decimal "broker_amount"
    t.string "invoice_no"
    t.boolean "bill_present", default: false, null: false
    t.float "dollar_rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "party_id", null: false
    t.bigint "broker_id"
    t.decimal "pending_amount", precision: 15, scale: 4, default: "0.0"
    t.index ["broker_id"], name: "index_sales_on_broker_id"
    t.index ["party_id"], name: "index_sales_on_party_id"
  end

  create_table "stock_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_id", null: false
    t.string "notes"
    t.index ["stock_id"], name: "index_stock_histories_on_stock_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "stock_key"
    t.integer "shape", null: false
    t.integer "color", null: false
    t.integer "clarity", null: false
    t.float "carat", null: false
    t.float "weight", null: false
    t.float "rap", null: false
    t.float "discount_percentage"
    t.float "additional_disc_1"
    t.float "additional_disc_2"
    t.float "additional_disc_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "purchase_id", null: false
    t.integer "state"
    t.decimal "amount", precision: 15, scale: 4, null: false
    t.index ["purchase_id"], name: "index_stocks_on_purchase_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "mobile_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expenses", "stocks"
  add_foreign_key "payments", "parties"
  add_foreign_key "payments", "purchases"
  add_foreign_key "purchases", "brokers"
  add_foreign_key "purchases", "parties"
  add_foreign_key "receipts", "parties"
  add_foreign_key "receipts", "sales"
  add_foreign_key "sale_items", "sales"
  add_foreign_key "sale_items", "stocks"
  add_foreign_key "sales", "brokers"
  add_foreign_key "sales", "parties"
  add_foreign_key "stock_histories", "stocks"
  add_foreign_key "stocks", "purchases"
end
