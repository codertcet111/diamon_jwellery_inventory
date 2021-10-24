class AddBalanceAndOpeningAmountInLedgers < ActiveRecord::Migration[5.2]
  def change
  	add_column :parties,:balance_amount, :float, default: 0.0
    add_column :ledgers,:balance_amount, :float, default: 0.0
    add_column :brokers,:balance_amount, :float, default: 0.0
    add_column :parties,:opening_amount, :float, default: 0.0
    add_column :ledgers,:opening_amount, :float, default: 0.0
    add_column :brokers,:opening_amount, :float, default: 0.0
  end
end
