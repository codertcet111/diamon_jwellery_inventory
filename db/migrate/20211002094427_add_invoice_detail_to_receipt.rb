class AddInvoiceDetailToReceipt < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :invoice_number, :string
    add_column :sales, :invoice_date, :datetime
  end
end
