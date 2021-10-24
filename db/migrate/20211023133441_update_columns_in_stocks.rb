class UpdateColumnsInStocks < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :shape, :integer, default: nil
    change_column :stocks, :color, :integer, default: nil
    change_column :stocks, :clarity, :integer, default: nil
    change_column :stocks, :carat, :float, default: 0.0
    change_column :stocks, :weight, :float, default: 0.0
    change_column :stocks, :rap, :float, default: 0.0
    change_column :stocks, :discount_percentage, :float, default: 0.0
    change_column :stocks, :additional_disc_1, :float, default: 0.0
    change_column :stocks, :additional_disc_2, :float, default: 0.0
    change_column :stocks, :additional_disc_3, :float, default: 0.0
    change_column :stocks, :stock_sub_type_id, :bigint, default: 0.0
    change_column :stocks, :color_shades, :integer, default: nil
    change_column :stocks, :fancy_color, :integer, default: nil
    change_column :stocks, :color_intensity, :integer, default: nil
    change_column :stocks, :color_overtone, :integer, default: nil
    change_column :stocks, :flouresence, :integer, default: nil
    change_column :stocks, :lab, :integer, default: nil
    change_column :stocks, :cut, :integer, default: nil
    change_column :stocks, :polish, :integer, default: nil
    change_column :stocks, :symmetry, :integer, default: nil
    change_column :stocks, :black_table_inclusion, :integer, default: nil
    change_column :stocks, :black_crown_inclusion, :integer, default: nil
    change_column :stocks, :white_table_inclusion, :integer, default: nil
    change_column :stocks, :white_crown_inclusion, :integer, default: nil
    change_column :stocks, :milky_inclusion, :integer, default: nil
    change_column :stocks, :open_table_inclusion, :integer, default: nil
    change_column :stocks, :open_crown_inclusion, :integer, default: nil
    change_column :stocks, :open_pavilion_inclusion, :integer, default: nil
    change_column :stocks, :eye_clean_inclusion, :integer, default: nil
    change_column :stocks, :rough_origin, :integer, default: nil
    change_column :stocks, :heart_and_arrow, :integer, default: nil
  end
end
