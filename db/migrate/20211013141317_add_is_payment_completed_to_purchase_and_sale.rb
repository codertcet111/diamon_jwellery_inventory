class AddIsPaymentCompletedToPurchaseAndSale < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases,:is_payment_completed, :boolean, default: false
  	add_column :sales,:is_payment_completed, :boolean, default: false	
  end
end
