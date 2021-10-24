class AddDetailToBroker < ActiveRecord::Migration[5.2]
  def change
    add_column :brokers, :bank_account_no, :string
    add_column :brokers, :pin_code, :string
    add_column :brokers, :state, :string
    add_column :brokers, :country, :string
  end
end
