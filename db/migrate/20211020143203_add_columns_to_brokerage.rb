class AddColumnsToBrokerage < ActiveRecord::Migration[5.2]
  def change
  	create_table :brokerages_taxes do |t|
      t.references :brokerage, foreign_key: true
      t.references :tax, foreign_key: true

      t.timestamps
    end
    add_column :brokerages, :tax_amount, :float, default: 0.0
    add_column :brokerages, :final_amount, :float, default: 0.0
  end
end
