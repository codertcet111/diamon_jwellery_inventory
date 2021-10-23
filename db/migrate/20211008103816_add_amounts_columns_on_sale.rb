class AddAmountsColumnsOnSale < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :discount_amount, :float, default: 0.0
  	add_column :sales, :final_amount, :float, default: 0.0
  end
end
