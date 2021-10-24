class AddExtraParamsToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :color_shades, :integer
    add_column :stocks, :fancy_color, :integer
    add_column :stocks, :color_intensity, :integer
    add_column :stocks, :color_overtone, :integer
    add_column :stocks, :flouresence, :integer
    add_column :stocks, :lab, :integer
    add_column :stocks, :cut, :integer
    add_column :stocks, :polish, :integer
    add_column :stocks, :symmetry, :integer
    add_column :stocks, :black_table_inclusion, :integer
    add_column :stocks, :black_crown_inclusion, :integer
    add_column :stocks, :white_table_inclusion, :integer
    add_column :stocks, :white_crown_inclusion, :integer
    add_column :stocks, :milky_inclusion, :integer
    add_column :stocks, :open_table_inclusion, :integer
    add_column :stocks, :open_crown_inclusion, :integer
    add_column :stocks, :open_pavilion_inclusion, :integer
    add_column :stocks, :eye_clean_inclusion, :integer
    add_column :stocks, :rough_origin, :integer
  end
end
