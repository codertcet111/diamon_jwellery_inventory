class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :type
      t.float :amount

      t.timestamps
    end
  end
end
