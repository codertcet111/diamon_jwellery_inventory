class RemoveColumnOnDateFromStockHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :stock_histories, :on_date
  end
end
