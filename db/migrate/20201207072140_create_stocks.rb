class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :stockId
      t.string :shape, null: false
      t.string :color, null: false
      t.string :clarity, null: false
      t.float :carat, null: false
      t.float :weight, null: false
      t.float :Rap, null: false
      t.float :discount_percentage
      t.float :additional_disc_1
      t.float :additional_disc_2
      t.float :additional_disc_3
      t.integer :state, null: false

      t.timestamps
    end
  end
end
