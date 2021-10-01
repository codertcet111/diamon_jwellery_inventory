class AddPendingAmountToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :pending_amount, :decimal, precision: 15, scale: 4, default: 0
    add_column :sales, :pending_amount, :decimal, precision: 15, scale: 4, default: 0
  end
end
