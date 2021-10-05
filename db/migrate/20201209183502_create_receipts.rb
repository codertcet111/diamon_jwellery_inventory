class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.integer :receipt_mode
      t.datetime :date
      t.decimal :amount
      t.text :notes
      t.string :party_come
      t.string :pc_acc_name
      t.string :party_paid
      t.string :pp_acc_name
      t.timestamps
    end
  end
end
