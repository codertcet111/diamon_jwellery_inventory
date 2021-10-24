class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.float :debit_amount
      t.float :credit_amount
      t.datetime :transaction_date
      t.text :notes

      t.timestamps
    end
  end
end
