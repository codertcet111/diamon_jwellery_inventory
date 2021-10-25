class AddDueDateInPurchases < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :due_date, :datetime
  	add_column :purchases, :notes, :text
  	add_column :purchases, :overdue_days, :integer
  	remove_column :purchases, :discount_amount
  	add_column :sale_items, :purity, :string
  end
end
