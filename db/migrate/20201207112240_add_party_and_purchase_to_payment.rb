class AddPartyAndPurchaseToPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :party, foreign_key: true, null: false
    add_reference :payments, :purchase, foreign_key: true, null: false
  end
end
