class AddNotesAndCertificateNumberInStock < ActiveRecord::Migration[5.2]
  def change
  	add_column :stocks, :notes, :text
  	add_column :stocks, :certificate_number, :string
  end
end
