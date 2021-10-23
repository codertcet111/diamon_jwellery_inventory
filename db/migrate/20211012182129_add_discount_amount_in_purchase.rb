class AddDiscountAmountInPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :discount_amount, :float, default: 0.0
  end
end
