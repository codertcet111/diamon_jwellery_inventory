class RemoveUnecessaryColumnsFromStocks < ActiveRecord::Migration[5.2]
  def change
  	remove_column :stocks, :loose_selected_amount
  	remove_column :stocks, :loose_rejected_amount
  	remove_column :stocks, :loose_total_amount
  end
end
