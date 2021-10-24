class CreateSaleItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_items do |t|
      t.integer :shape
      t.integer :color
      t.integer :clarity
      t.float :carat
      t.float :weight
      t.float :rap
      t.float :discount_percentage
      t.float :additional_disc_1
      t.float :additional_disc_2
      t.float :additional_disc_3
      t.decimal :amount
      t.timestamps
    end
  end
end
