class AddToAndFromPartiesLedgers < ActiveRecord::Migration[5.2]
  def change
  	add_column :journal_vouchers, :ledger_1_id, :integer, null: true
  	add_column :journal_vouchers, :party_1_id, :integer, null: true
    add_column :journal_vouchers, :ledger_2_id, :integer, null: true
    add_column :journal_vouchers, :party_2_id, :integer, null: true
  end
end
