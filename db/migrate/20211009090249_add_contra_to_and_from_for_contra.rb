class AddContraToAndFromForContra < ActiveRecord::Migration[5.2]
  def change
  	add_column :contras, :ledger_1_id, :integer
    add_column :contras, :ledger_2_id, :integer
  end
end
