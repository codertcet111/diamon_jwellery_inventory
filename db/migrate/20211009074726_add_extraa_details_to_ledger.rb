class AddExtraaDetailsToLedger < ActiveRecord::Migration[5.2]
  def change
  	add_column :ledgers, :mobile_number, :string
  	add_column :ledgers, :qbc, :string
  	add_column :ledgers, :address, :text
  	add_column :ledgers, :gst_number, :string
  	add_column :ledgers, :pan_number, :string
  	add_column :ledgers, :adhaar_number, :string
  	add_column :ledgers, :bank_account_number, :string
  	add_column :ledgers, :pin_code, :string
  	add_column :ledgers, :state, :string
  	add_column :ledgers, :country, :string
  	add_column :ledgers, :city, :string
  end
end
