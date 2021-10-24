class AddBrokeragePaidToPurchaseAndSale < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :brokerage_paid_amount, :float, default: 0.0
  	add_column :sales, :brokerage_paid_amount, :float, default: 0.0
  	add_column :purchases, :is_brokerage_paid, :boolean, default: false
  	add_column :sales, :is_brokerage_paid, :boolean, default: false
  end
end
