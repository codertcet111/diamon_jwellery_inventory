class ChangeDueDateDatatype < ActiveRecord::Migration[5.2]
  def change
  	change_column :purchases, :due_date, :date, default: nil
  end
end
