class AddGstDetailsOnPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :gst_amount, :float
  	add_column :purchases, :gst_type, :integer
  	add_column :purchases, :total_amount, :float
  end
end
