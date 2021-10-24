class UpdateColumnInLedgerFinancialRecords < ActiveRecord::Migration[5.2]
  def change
    remove_column :ledger_financial_records, :ledger_id
    add_reference :ledger_financial_records, :ledgerable, polymorphic: true, index: { name: 'index_lfr_on_ledgerable_type_and_ledgerable_id' }
  end
end
