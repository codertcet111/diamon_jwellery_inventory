class AddInvoicableToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :invoicable, polymorphic: true
  end
end
