class AddPartyTypeToParty < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :party_type, :integer
  end
end
