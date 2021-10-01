class AddSumAmountToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :sum_amount, :decimal, precision: 15, scale: 4
  end
end
