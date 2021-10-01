class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :type, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
