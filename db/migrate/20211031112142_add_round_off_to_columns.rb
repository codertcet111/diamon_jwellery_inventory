class AddRoundOffToColumns < ActiveRecord::Migration[5.2]
  def change
  	add_column :purchases, :round_off_amount, :string
  	add_column :sales, :round_off_amount, :string
  end
end
