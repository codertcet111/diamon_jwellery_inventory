class CreateLedgerExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :ledger_expenses do |t|
      t.string :title
      t.references :ledger, foreign_key: true
      t.float :amount
      t.text :notes
      t.text :payment_notes

      t.timestamps
    end
  end
end
