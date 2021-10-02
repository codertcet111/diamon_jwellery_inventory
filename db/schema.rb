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

ActiveRecord::Schema.define(version: 2021_10_02_094637) do

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
    t.string "bank_account_no"
    t.string "pin_code"
    t.string "state"
    t.string "country"
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

  create_table "ledger_expenses", force: :cascade do |t|
    t.string "title"
    t.bigint "ledger_id"
    t.float "amount"
    t.text "notes"
    t.text "payment_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_ledger_expenses_on_ledger_id"
  end

  create_table "ledger_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ledgers", force: :cascade do |t|
    t.string "name"
    t.bigint "ledger_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_group_id"], name: "index_ledgers_on_ledger_group_id"
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
    t.string "bank_account_no"
    t.string "pin_code"
    t.string "state"
    t.string "country"
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
    t.string "cheque_number"
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
    t.string "invoice_number"
    t.datetime "invoice_date"
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
    t.string "cheque_number"
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
    t.string "invoice_number"
    t.datetime "invoice_date"
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

  create_table "stock_sub_types", force: :cascade do |t|
    t.string "name"
    t.string "weight_unit"
    t.bigint "stock_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_type_id"], name: "index_stock_sub_types_on_stock_type_id"
  end

  create_table "stock_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "stock_sub_type_id"
    t.integer "color_shades"
    t.integer "fancy_color"
    t.integer "color_intensity"
    t.integer "color_overtone"
    t.integer "flouresence"
    t.integer "lab"
    t.integer "cut"
    t.integer "polish"
    t.integer "symmetry"
    t.integer "black_table_inclusion"
    t.integer "black_crown_inclusion"
    t.integer "white_table_inclusion"
    t.integer "white_crown_inclusion"
    t.integer "milky_inclusion"
    t.integer "open_table_inclusion"
    t.integer "open_crown_inclusion"
    t.integer "open_pavilion_inclusion"
    t.integer "eye_clean_inclusion"
    t.integer "rough_origin"
    t.integer "heart_and_arrow"
    t.string "rapnet_id"
    t.string "rapnet_dollar"
    t.string "rapnet_discount_percentage"
    t.string "rapnet_price_after_disc"
    t.string "rapnet_amount_dollar_after_disc"
    t.string "max"
    t.string "min"
    t.string "hgt_height"
    t.string "tbl_table"
    t.string "td_percentage"
    t.string "hAndA"
    t.string "BIC"
    t.string "BIS"
    t.string "WIC"
    t.string "col_tinge"
    t.float "loose_total_caret"
    t.float "loose_selection_carat"
    t.float "loose_rejection_carat"
    t.float "loose_rate_per_caret"
    t.float "loose_total_amount"
    t.float "loose_selected_amount"
    t.float "loose_rejected_amount"
    t.index ["purchase_id"], name: "index_stocks_on_purchase_id"
    t.index ["stock_sub_type_id"], name: "index_stocks_on_stock_sub_type_id"
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
  add_foreign_key "ledger_expenses", "ledgers"
  add_foreign_key "ledgers", "ledger_groups"
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
  add_foreign_key "stock_sub_types", "stock_types"
  add_foreign_key "stocks", "purchases"
end
