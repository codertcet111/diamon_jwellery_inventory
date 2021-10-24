class AddPlaceOfSupplyToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :place_of_supply, :string
  end
end
