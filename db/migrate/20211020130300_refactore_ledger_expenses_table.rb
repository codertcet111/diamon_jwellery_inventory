class RefactoreLedgerExpensesTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :ledger_expenses, :title
  	remove_column :ledger_expenses, :payment_notes
  	remove_column :ledger_expenses, :payment_mode
  	remove_column :ledger_expenses, :cheque_number
  	add_column :ledger_expenses, :invoice_number, :string
  	add_column :ledger_expenses, :date, :datetime
  	add_column :ledger_expenses, :final_amount, :float, default: 0.0
  end
end
