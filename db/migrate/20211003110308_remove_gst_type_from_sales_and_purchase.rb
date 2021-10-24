class RemoveGstTypeFromSalesAndPurchase < ActiveRecord::Migration[5.2]
  def change
  	remove_column :sales, :gst_type
  	remove_column :purchases, :gst_type
  end
end
