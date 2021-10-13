class AddPaymentModeInLedgerExpenses < ActiveRecord::Migration[5.2]
  def change
  	add_column :ledger_expenses, :payment_mode, :integer
  	add_column :ledger_expenses, :cheque_number, :string
  end
end
