class Broker < ApplicationRecord
  has_many :purchases
  has_many :sales

  rails_admin do
    show do
      exclude_fields :address
      field :broker_address
    end
    list do
      exclude_fields :address
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
   end
  end

  def broker_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def broker_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
