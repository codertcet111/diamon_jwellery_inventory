class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.datetime :sale_date
      t.integer :terms
      t.float :broker_percentage
      t.decimal :broker_amount
      t.string :invoice_no
      t.boolean :bill_present, default: false
      t.float :dollar_rate
      t.timestamps
    end
  end
end
