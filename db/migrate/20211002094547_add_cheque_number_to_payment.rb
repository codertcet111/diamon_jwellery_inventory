class AddChequeNumberToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :cheque_number, :string
  end
end
