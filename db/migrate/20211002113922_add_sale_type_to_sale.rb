class AddSaleTypeToSale < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :sale_type, :integer
  end
end
