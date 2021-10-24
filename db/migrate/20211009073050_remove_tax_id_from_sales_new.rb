class RemoveTaxIdFromSalesNew < ActiveRecord::Migration[5.2]
  def change
  	remove_column :sales, :tax_id
  	remove_column :sales, :invoice_no
  end
end
