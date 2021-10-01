class RemovePreviousStateFromStock < ActiveRecord::Migration[5.2]
  def change
    remove_column :stocks, :previous_state_id, :integer
  end
end
