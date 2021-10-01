class CreateStockStates < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
