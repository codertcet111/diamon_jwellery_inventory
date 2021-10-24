class AddAmountToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :amount, :decimal, precision: 15, scale: 4
    change_column :purchases, :pending_amount, :decimal, precision: 15, scale: 4
    change_column :payments, :amount, :decimal, precision: 15, scale: 4
    remove_column :purchases, :amount
  end
end
