class CreateFinancialYear < ActiveRecord::Migration[5.2]
  def change
    create_table :financial_years do |t|
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
