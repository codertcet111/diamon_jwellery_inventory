class AddBrokerageAmountAndPercentageInPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :broker_percentage, :float
  	add_column :purchases, :broker_amount, :float
  end
end
