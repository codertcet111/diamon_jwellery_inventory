class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :stock_primary_id
      t.datetime :purchase_date
      t.integer :terms
      t.float :dollar_rate
      t.boolean :bill_present, default: false
      t.float :pending_amount
      t.float :amount

      t.timestamps
    end
  end
end
