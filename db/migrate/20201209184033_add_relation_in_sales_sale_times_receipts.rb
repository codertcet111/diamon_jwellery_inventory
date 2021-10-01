class AddRelationInSalesSaleTimesReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales, :party, foreign_key: true, null: false
    add_reference :sales, :broker, foreign_key: true
    add_reference :sale_items, :stock, foreign_key: true, null: false
    add_reference :sale_items, :sale, foreign_key: true, null: false
    add_reference :receipts, :party, foreign_key: true, null: false
    add_reference :receipts, :sale, foreign_key: true, null: false
  end
end
