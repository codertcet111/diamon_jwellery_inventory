class CreateStockSubTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_sub_types do |t|
      t.string :name
      t.string :weight_unit
      t.references :stock_type, foreign_key: true

      t.timestamps
    end
  end
end
