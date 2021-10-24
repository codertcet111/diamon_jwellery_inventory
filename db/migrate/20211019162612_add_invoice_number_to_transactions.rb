class AddInvoiceNumberToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :invoice_number, :string
  end
end
