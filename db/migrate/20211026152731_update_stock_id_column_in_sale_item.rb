class UpdateStockIdColumnInSaleItem < ActiveRecord::Migration[5.2]
  def change
  	change_column :sale_items, :stock_id, :bigint, default: nil
  end
end
