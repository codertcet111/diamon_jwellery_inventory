class AddFinalAmountInPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :final_amount, :float
  end
end
