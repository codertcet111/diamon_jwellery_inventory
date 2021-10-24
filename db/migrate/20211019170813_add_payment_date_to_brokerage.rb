class AddPaymentDateToBrokerage < ActiveRecord::Migration[5.2]
  def change
  	add_column :brokerages, :payment_date, :datetime
  end
end
