class AddLedgerToBrokerage < ActiveRecord::Migration[5.2]
  def change
  	add_reference :brokerages, :ledger, foreign_key: true
  end
end
