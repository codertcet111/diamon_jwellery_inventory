class AddColumnsToCompanyDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :company_details, :bank_address_detail, :text
    add_column :company_details, :bank_account_number, :string
    add_column :company_details, :rtgs_code, :string
    add_column :company_details, :terms_and_condition, :text
  end
end
