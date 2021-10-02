class AddStockSubTypeToStock < ActiveRecord::Migration[5.2]
  def change
    add_reference :stocks, :stock_sub_type, index: true
  end
end
