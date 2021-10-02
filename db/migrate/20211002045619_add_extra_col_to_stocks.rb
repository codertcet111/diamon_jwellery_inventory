class AddExtraColToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :rapnet_id, :string
    add_column :stocks, :rapnet_dollar, :string
    add_column :stocks, :rapnet_discount_percentage, :string
    add_column :stocks, :rapnet_price_after_disc, :string
    add_column :stocks, :rapnet_amount_dollar_after_disc, :string
    add_column :stocks, :max, :string
    add_column :stocks, :min, :string
    add_column :stocks, :hgt_height, :string
    add_column :stocks, :tbl_table, :string
    add_column :stocks, :td_percentage, :string
    add_column :stocks, :hAndA, :string
    add_column :stocks, :BIC, :string
    add_column :stocks, :BIS, :string
    add_column :stocks, :WIC, :string
    add_column :stocks, :col_tinge, :string
  end
end
