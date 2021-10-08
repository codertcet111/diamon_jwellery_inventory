class CreateSalesTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_taxes do |t|
      t.references :sale, foreign_key: true
      t.references :tax, foreign_key: true

      t.timestamps
    end
  end

  def up
    # create join table
    create_table :sales_taxes do |t|
      t.references :sale, foreign_key: true
      t.references :tax, foreign_key: true

      t.timestamps
    end
    Sale.all.each do |sale|
      SalesTaxes.create(sale_id: sale.id, tax_id: sale.tax_id)
    end
    remove_reference :sales, :tax, foreign_key: true
  end

  def down
    # add reference column back
    add_reference :sales, :tax, foreign_key: true
    # Using a model after changing its table
    # https://api.rubyonrails.org/classes/ActiveRecord/Migration.html#class-ActiveRecord::Migration-label-Using+a+model+after+changing+its+table
    Sale.reset_column_information
    # associate book with author, even though it will just be one.
    SalesTaxes.all.each do |sale_tax|
      Sale.find(sale_tax.sale_id).update_attribute(:tax_id, sale_tax.tax_id)
    end
    # remove join table
    drop_table :sales_taxes
  end
end
