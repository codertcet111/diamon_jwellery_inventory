class AddPackageReceivedDatePurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :package_received_date, :date
  end
end
