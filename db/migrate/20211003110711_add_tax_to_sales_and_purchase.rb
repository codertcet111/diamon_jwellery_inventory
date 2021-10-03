class AddTaxToSalesAndPurchase < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales, :tax, foreign_key: true
    add_reference :purchases, :tax, foreign_key: true
  end
end
