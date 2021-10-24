class AddDetailToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :bank_account_no, :string
    add_column :parties, :pin_code, :string
    add_column :parties, :state, :string
    add_column :parties, :country, :string
  end
end
