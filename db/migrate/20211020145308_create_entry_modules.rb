class CreateEntryModules < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_modules do |t|
      t.float :total_debit
      t.float :total_credit
      t.text :narration

      t.timestamps
    end
  end
end
