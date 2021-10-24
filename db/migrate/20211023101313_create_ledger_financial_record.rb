class CreateLedgerFinancialRecord < ActiveRecord::Migration[5.2]
  def change
    create_table :ledger_financial_records do |t|
      t.decimal :opening_balance
      t.decimal :closing_balance
    end
    add_reference :ledger_financial_records, :financial_year, foreign_key: true, index: true
    add_reference :ledger_financial_records, :ledger, foreign_key: true, index: true
  end
end
