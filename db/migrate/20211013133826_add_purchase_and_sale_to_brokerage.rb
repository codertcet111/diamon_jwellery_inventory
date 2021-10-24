class AddPurchaseAndSaleToBrokerage < ActiveRecord::Migration[5.2]
  def change
  	add_reference :brokerages, :purchase, foreign_key: true, null: true
  	add_reference :brokerages, :sale, foreign_key: true, null: true
  end
end
