class RemoveStockStates < ActiveRecord::Migration[5.2]
  def change
    remove_column :stocks, :current_state_id
    remove_column :stock_histories, :from_state_id
    remove_column :stock_histories, :to_state_id
    add_column :stocks, :state, :integer, default: 0
    add_column :stock_histories, :notes, :string
    drop_table :stock_states
  end
end
