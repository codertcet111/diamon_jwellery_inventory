class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :stockId
      t.string :shape
      t.string :color
      t.string :clarity
      t.float :carat
      t.float :weight
      t.float :Rap
      t.float :discount_percentage
      t.float :additional_disc_1
      t.float :additional_disc_2
      t.float :additional_disc_3
      t.integer :state

      t.timestamps
    end
  end
end
