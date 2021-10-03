class RenameGstAmountToTax < ActiveRecord::Migration[5.2]
  def change
  	rename_column :sales, :gst_amount, :tax_amount
  	rename_column :purchases, :gst_amount, :tax_amount 
  end
end
