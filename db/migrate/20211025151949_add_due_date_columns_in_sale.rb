class AddDueDateColumnsInSale < ActiveRecord::Migration[5.2]
  def change
  	add_column :sales, :due_date, :date
  	add_column :sales, :notes, :text
  	add_column :sales, :overdue_days, :integer
  end
end
