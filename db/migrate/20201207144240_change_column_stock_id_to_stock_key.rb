class ChangeColumnStockIdToStockKey < ActiveRecord::Migration[5.2]
  def change
    rename_column :stocks, :stockId, :stock_key
    rename_column :stocks, :Rap, :rap
  end
end
