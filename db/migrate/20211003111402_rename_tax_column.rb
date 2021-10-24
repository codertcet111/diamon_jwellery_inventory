class RenameTaxColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :taxes, :tax_name, :name
  end
end
