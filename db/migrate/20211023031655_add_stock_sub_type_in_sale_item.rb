class AddStockSubTypeInSaleItem < ActiveRecord::Migration[5.2]
  def change
  	add_reference :sale_items, :stock_sub_type, foreign_key: true
  end
end
