class CreateStockPcRanges < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_pc_ranges do |t|
      t.string :name
      t.float :min_value
      t.float :max_value

      t.timestamps
    end
  end
end
