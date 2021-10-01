class Sale < ApplicationRecord

  has_many :sale_items, inverse_of: :sale, dependent: :destroy
  has_many :receipts, inverse_of: :sale, dependent: :destroy
  belongs_to :party
  belongs_to :broker

  accepts_nested_attributes_for :sale_items
  accepts_nested_attributes_for :receipts

  rails_admin do
    edit do
      field :sale_date do
        required true
      end
      # field :terms do
      #   required true
      # end
      # field :dollar_rate do
      #   required true
      # end
      include_all_fields
      field :party do
        required true
      end
      exclude_fields :pending_amount
      exclude_fields :receipts
    end
    include_all_fields
    field :terms do
      label 'Terms (In Days)'
    end
  end

end