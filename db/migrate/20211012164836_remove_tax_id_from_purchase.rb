class RemoveTaxIdFromPurchase < ActiveRecord::Migration[5.2]
  def change
  	remove_column :purchases, :tax_id
  end
end
