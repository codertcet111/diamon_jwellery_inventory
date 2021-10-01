class CreateStockHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_histories do |t|
      t.integer :to_state
      t.integer :from_state
      t.datetime :on_date

      t.timestamps
    end
  end
end
