class AddColumnWeightLossInExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :weight_loss, :float, default: 0.0
  end
end
