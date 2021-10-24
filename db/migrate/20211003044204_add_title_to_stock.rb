class AddTitleToStock < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :title, :string
  end
end
