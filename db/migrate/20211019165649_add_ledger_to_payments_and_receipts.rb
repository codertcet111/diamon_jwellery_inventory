class AddLedgerToPaymentsAndReceipts < ActiveRecord::Migration[5.2]
  def change
  	add_reference :payments, :ledger, foreign_key: true
  	add_reference :receipts, :ledger, foreign_key: true
  end
end
