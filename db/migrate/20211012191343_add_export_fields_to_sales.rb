class AddExportFieldsToSales < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :pre_carriage_by, :string
  	add_column :sales, :place_of_receipt_by_pre_carrier, :string
  	add_column :sales, :vessel_or_flight_no, :string
  	add_column :sales, :port_of_discharge, :string
  	add_column :sales, :port_of_loading, :string
  	add_column :sales, :final_destination, :string
  	add_column :sales, :export_invoice_sale_box_approx_weight_in_gram, :float, default: 0.0
  	add_column :sale_items, :export_invoice_stock_description_name, :string
  end
end
