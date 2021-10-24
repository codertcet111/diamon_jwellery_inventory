class AddClosingBalanceToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :closing_balance, :decimal
  end
end
