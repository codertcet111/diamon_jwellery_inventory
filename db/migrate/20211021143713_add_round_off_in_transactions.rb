class AddRoundOffInTransactions < ActiveRecord::Migration[5.2]
  def change
  	add_column :transactions, :round_off_amount, :float
  end
end
