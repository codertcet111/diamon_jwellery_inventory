class AddGstDetailsOnSales < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :gst_amount, :float, default: 0.0
  	add_column :sales, :gst_type, :integer
  	add_column :sales, :total_amount, :float, default: 0.0
  end
end