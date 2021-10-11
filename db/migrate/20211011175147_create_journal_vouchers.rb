class CreateJournalVouchers < ActiveRecord::Migration[5.2]
  def change
    create_table :journal_vouchers do |t|
      t.float :amount
      t.datetime :date
      t.text :notes

      t.timestamps
    end
  end
end
