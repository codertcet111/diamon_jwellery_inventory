class AddProprietorNameToCompanyDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :company_details, :proprietor_name, :string
  end
end
