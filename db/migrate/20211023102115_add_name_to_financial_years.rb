class AddNameToFinancialYears < ActiveRecord::Migration[5.2]
  def change
    add_column :financial_years, :name, :string
  end
end
