class AddStockPcRangeInStock < ActiveRecord::Migration[5.2]
  def change
  	add_reference :stocks, :stock_pc_range, foreign_key: true, null: true
  end
end
