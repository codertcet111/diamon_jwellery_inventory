class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name
      t.string :mobile
      t.string :qbc
      t.text :address
      t.string :reference_1
      t.string :reference_2
      t.string :reference_3
      t.string :gst_no
      t.string :pan_no
      t.string :adhaar_no
      t.string :mobile_2

      t.timestamps
    end
  end
end
