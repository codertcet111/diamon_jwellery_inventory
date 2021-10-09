class RenameRatePerCaratStock < ActiveRecord::Migration[5.2]
  def change
  	rename_column :stocks, :loose_rate_per_caret, :rate_per_caret
  end
end
