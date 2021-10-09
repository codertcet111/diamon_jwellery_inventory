class CreateContras < ActiveRecord::Migration[5.2]
  def change
    create_table :contras do |t|
      t.float :amount
      t.datetime :date
      t.text :notes

      t.timestamps
    end
  end
end
