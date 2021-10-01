class AddStockToStockHistory < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_histories, :stock, foreign_key: true, null: false
  end
end
