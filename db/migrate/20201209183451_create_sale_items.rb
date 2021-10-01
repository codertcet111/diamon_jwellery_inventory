class CreateSaleItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_items do |t|
      t.integer :shape, null: false
      t.integer :color, null: false
      t.integer :clarity, null: false
      t.float :carat, null: false
      t.float :weight, null: false
      t.float :rap, null: false
      t.float :discount_percentage
      t.float :additional_disc_1
      t.float :additional_disc_2
      t.float :additional_disc_3
      t.decimal :amount, null: false
      t.timestamps
    end
  end
end
