class AddPartyAndBrokerToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_reference :purchases, :party, foreign_key: true
    add_reference :purchases, :broker, foreign_key: true
  end
end
