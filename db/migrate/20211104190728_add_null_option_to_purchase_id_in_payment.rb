class AddNullOptionToPurchaseIdInPayment < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :payments, :purchase_id, true
  end
end
