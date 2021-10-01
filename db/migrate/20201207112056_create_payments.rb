class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :payment_mode, null: false
      t.datetime :date, null: false
      t.float :amount, null: false
      t.text :notes
      t.string :party_come
      t.string :pc_acc_name
      t.string :party_paid
      t.string :pp_acc_name
      t.timestamps
    end
  end
end
