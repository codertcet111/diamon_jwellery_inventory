class CreateJoinTablePurchasesTaxes < ActiveRecord::Migration[5.2]
  # def change
  #   create_table :purchases_taxes do |t|
  #     t.references :purchase, foreign_key: true
  #     t.references :tax, foreign_key: true

  #     t.timestamps
  #   end
  # end

  def up
    # create join table
    create_table :purchases_taxes do |t|
      t.references :purchase, foreign_key: true
      t.references :tax, foreign_key: true

      t.timestamps
    end
    # Purchase.all.each do |purchase|
    #   PurchasesTaxes.create(purchase_id: purchase.id, tax_id: purchase.tax_id)
    # end
    # remove_reference :purchases, :tax, foreign_key: true
  end

  def down
    # add reference column back
    add_reference :purchases, :tax, foreign_key: true
    # Using a model after changing its table
    # https://api.rubyonrails.org/classes/ActiveRecord/Migration.html#class-ActiveRecord::Migration-label-Using+a+model+after+changing+its+table
    purchase.reset_column_information
    # associate book with author, even though it will just be one.
    PurchasesTaxes.all.each do |purchase_tax|
      purchase.find(purchase_tax.purchase_id).update_attribute(:tax_id, purchase_tax.tax_id)
    end
    # remove join table
    drop_table :purchases_taxes
  end
end
