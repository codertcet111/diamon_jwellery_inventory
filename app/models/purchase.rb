class Purchase < ApplicationRecord
  belongs_to :party
  belongs_to :broker
  has_many :stocks, inverse_of: :purchase, dependent: :destroy
  has_many :payments, inverse_of: :purchase, dependent: :destroy

  accepts_nested_attributes_for :stocks
  accepts_nested_attributes_for :payments

  rails_admin do
   edit do
    field :purchase_date do
      required true
    end
    field :terms do
      required true
    end
    field :dollar_rate do
      required true
    end
    include_all_fields
    field :party do
      required true
    end
    exclude_fields :pending_amount
    exclude_fields :payments
   end
  end

end
