class AddPurchaseToStock < ActiveRecord::Migration[5.2]
  def change
    add_reference :stocks, :purchase, foreign_key: true, null: false
  end
end
