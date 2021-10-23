class AddGstDetailsOnPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :gst_amount, :float, default: 0.0
  	add_column :purchases, :gst_type, :integer
  	add_column :purchases, :total_amount, :float, default: 0.0
  end
end
