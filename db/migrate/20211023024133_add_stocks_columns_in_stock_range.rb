class AddStocksColumnsInStockRange < ActiveRecord::Migration[5.2]
  def change
  	add_column :stock_pc_ranges, :purchase_stocks, :float, default: 0.0
  	add_column :stock_pc_ranges, :sale_stocks, :float, default: 0.0
  	add_column :stock_pc_ranges, :balance_stocks, :float, default: 0.0
  	add_reference :sale_items, :stock_pc_range, foreign_key: true
  end
end
