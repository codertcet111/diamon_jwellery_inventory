class CreateBrokerages < ActiveRecord::Migration[5.2]
  def change
    create_table :brokerages do |t|
      t.float :amount
      t.integer :payment_mode
      t.string :cheque_number
      t.references :broker, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
