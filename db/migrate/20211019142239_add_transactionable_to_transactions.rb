class AddTransactionableToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :transnable, polymorphic: true
  end
end
