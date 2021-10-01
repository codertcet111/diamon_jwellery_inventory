class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.datetime :sale_date, null: false
      t.integer :terms, null: false
      t.float :broker_percentage
      t.decimal :broker_amount
      t.string :invoice_no
      t.boolean :bill_present, null: false, default: false
      t.float :dollar_rate, null: false
      t.timestamps
    end
  end
end
