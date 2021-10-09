class Purchase < ApplicationRecord
  belongs_to :party
  belongs_to :broker, optional: true
  has_many :stocks, inverse_of: :purchase, dependent: :destroy
  has_many :payments, inverse_of: :purchase, dependent: :destroy
  belongs_to :tax, optional: true

  accepts_nested_attributes_for :stocks
  accepts_nested_attributes_for :payments

  after_create :perform_calculations

  rails_admin do
   edit do
    field :purchase_date do
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
    exclude_fields :payments
    exclude_fields :tax_amount
    exclude_fields :total_amount
    exclude_fields :tax
   end
  end

  def perform_calculations
    sum_amount = stocks.sum(:amount)
    self.update_column(:total_amount, sum_amount)
    # Now Tax
    tax_per = self.tax.tax_percentage rescue 0
    self.update_column(:tax_amount, sum_amount * ( tax_per.to_f / 100.0))
  end

end
