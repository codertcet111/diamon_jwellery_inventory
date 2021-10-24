class RemoveColumnsFromEntryModules < ActiveRecord::Migration[5.2]
  def change
    remove_column :entry_modules, :total_credit
    remove_column :entry_modules, :total_debit
  end
end
