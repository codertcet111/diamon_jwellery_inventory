class AddChequeNumberToReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :receipts, :cheque_number, :string
  end
end
