class AddDiscounColumnInPurchase < ActiveRecord::Migration[5.2]
  def change
  	unless column_exists? :purchases, :discount_amount
	  add_column :purchases, :discount_amount, :decimal
	end
  end
end
