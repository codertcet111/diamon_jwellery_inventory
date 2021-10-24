class AddImageUrlInStocks < ActiveRecord::Migration[5.2]
  def change
  	add_column :stocks, :image_url, :text
  end
end
