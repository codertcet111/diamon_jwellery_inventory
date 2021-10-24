class AddBrokerageAmountAndPercentageInPurchase < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :broker_percentage, :float, default: 0.0
  	add_column :purchases, :broker_amount, :float, default: 0.0
  end
end
