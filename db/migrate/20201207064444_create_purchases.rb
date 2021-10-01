class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :stock_primary_id
      t.datetime :purchase_date, null: false
      t.integer :terms, null: false
      t.float :dollar_rate, null: false
      t.boolean :bill_present, null: false, default: false
      t.float :pending_amount
      t.float :amount

      t.timestamps
    end
  end
end
