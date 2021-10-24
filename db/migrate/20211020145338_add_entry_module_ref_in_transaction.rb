class AddEntryModuleRefInTransaction < ActiveRecord::Migration[5.2]
  def change
  	add_reference :transactions, :entry_module, foreign_key: true
  end
end
