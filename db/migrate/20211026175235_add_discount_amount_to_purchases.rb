class AddDiscountAmountToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :discount_amount, :decimal
    add_column :sales, :discount_amount, :decimal
  end
end
