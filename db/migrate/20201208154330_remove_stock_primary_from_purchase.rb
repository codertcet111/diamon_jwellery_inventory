class RemoveStockPrimaryFromPurchase < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :stock_primary_id
  end
end
