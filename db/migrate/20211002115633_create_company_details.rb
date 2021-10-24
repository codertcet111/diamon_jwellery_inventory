class CreateCompanyDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :company_details do |t|
      t.string :name
      t.string :gst
      t.text :address
      t.string :pan_card
      t.string :adhaar
      t.string :mobile_number
      t.string :qbc_no

      t.timestamps
    end
  end
end
