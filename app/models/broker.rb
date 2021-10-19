class Broker < ApplicationRecord
  include Transnable
  has_many :purchases
  has_many :sales
  has_many :brokerages

  rails_admin do
    show do
      exclude_fields :address
      field :broker_address
      exclude_fields :transactions
    end
    list do
      exclude_fields :address
      exclude_fields :transactions
      field :broker_address_short do
        label 'Broker Address'
      end
    end
   edit do
    field :name, :string do
      required true
    end
    field :mobile, :integer do
      required true
    end
    include_all_fields
    exclude_fields :sales
    exclude_fields :purchases
    exclude_fields :brokerages
    exclude_fields :transactions
   end
  end

  def broker_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def broker_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
