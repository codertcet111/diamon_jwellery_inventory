class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.string :tax_name
      t.float :tax_percentage

      t.timestamps
    end
  end
end
