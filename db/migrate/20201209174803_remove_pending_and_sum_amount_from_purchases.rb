class RemovePendingAndSumAmountFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :sum_amount
    remove_column :purchases, :pending_amount
  end
end
