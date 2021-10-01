class AddStockToExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :stock, foreign_key: true, null: false
  end
end
