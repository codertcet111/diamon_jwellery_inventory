class AddStateReferencesToAllModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :stocks, :state
    remove_column :stock_histories, :from_state
    remove_column :stock_histories, :to_state
    add_column :stocks, :current_state_id, :integer, index: true
    add_column :stocks, :previous_state_id, :integer
    add_column :stock_histories, :from_state_id, :integer
    add_column :stock_histories, :to_state_id, :integer
  end
end
