class AddLooseColumnsToStock < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :loose_total_caret, :float, default: 0.0
    add_column :stocks, :loose_selection_carat, :float, default: 0.0
    add_column :stocks, :loose_rejection_carat, :float, default: 0.0
    add_column :stocks, :loose_rate_per_caret, :float, default: 0.0
    add_column :stocks, :loose_total_amount, :float, default: 0.0
    add_column :stocks, :loose_selected_amount, :float, default: 0.0
    add_column :stocks, :loose_rejected_amount, :float, default: 0.0
  end
end
