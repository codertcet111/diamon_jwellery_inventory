class AddPurityFieldInStock < ActiveRecord::Migration[5.2]
  def change
  	add_column :stocks, :purity, :string
  end
end
