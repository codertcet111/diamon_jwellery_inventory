class AddColumnsInSalesItem < ActiveRecord::Migration[5.2]
  def change
  	add_column :sale_items, :rate_per_carat, :float
  	add_column :sale_items, :notes, :text
  end
end
