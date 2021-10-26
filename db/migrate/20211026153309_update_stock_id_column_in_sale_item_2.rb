class UpdateStockIdColumnInSaleItem2 < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :sale_items, :stock_id, true
  end
end
