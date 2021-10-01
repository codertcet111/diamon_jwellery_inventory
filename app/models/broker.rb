class Broker < ApplicationRecord
  has_many :purchases
  has_many :sales

  rails_admin do
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

end
