class AddInvoiceDetailToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :invoice_number, :string
    add_column :purchases, :invoice_date, :datetime
  end
end
