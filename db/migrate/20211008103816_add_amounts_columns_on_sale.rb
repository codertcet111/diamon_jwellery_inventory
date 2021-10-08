class AddAmountsColumnsOnSale < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :discount_amount, :float
  	add_column :sales, :final_amount, :float
  end
end
