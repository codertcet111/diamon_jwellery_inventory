class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :name, null: false
      t.string :mobile, null: false
      t.string :qbc
      t.text :address, null: false
      t.string :reference_1
      t.string :reference_2
      t.string :reference_3
      t.string :gst_no, null: false
      t.string :pan_no, null: false
      t.string :adhaar_no
      t.string :mobile_2

      t.timestamps
    end
  end
end
