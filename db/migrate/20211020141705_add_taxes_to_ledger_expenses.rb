class AddTaxesToLedgerExpenses < ActiveRecord::Migration[5.2]
  def change
  	create_table :ledger_expenses_taxes do |t|
      t.references :ledger_expense, foreign_key: true
      t.references :tax, foreign_key: true

      t.timestamps
    end
    add_column :ledger_expenses, :tax_amount, :float, default: 0.0
  end
end
