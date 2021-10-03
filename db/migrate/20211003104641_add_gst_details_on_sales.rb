class AddGstDetailsOnSales < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :gst_amount, :float
  	add_column :sales, :gst_type, :integer
  	add_column :sales, :total_amount, :float
  end
end