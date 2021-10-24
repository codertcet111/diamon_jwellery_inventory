class RemoveTaxIdFromSales < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :sales, column: :tax_id
  	remove_foreign_key :purchases, column: :tax_id
  end
end
