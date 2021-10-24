class AddHeartToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :heart_and_arrow, :integer
  end
end
