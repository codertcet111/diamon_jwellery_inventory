class Purchase < ApplicationRecord
  belongs_to :party
  belongs_to :broker, optional: true
  has_many :stocks, inverse_of: :purchase, dependent: :destroy
  has_many :payments, inverse_of: :purchase, dependent: :destroy
  belongs_to :tax, optional: true

  enum terms_type: ["Days","COD","Advance"]
  accepts_nested_attributes_for :stocks
  accepts_nested_attributes_for :payments

  after_create :perform_calculations

  rails_admin do
    show do
      exclude_fields :terms, :terms_type
      field :purchase_terms
    end
    list do
      exclude_fields :terms, :terms_type
      field :purchase_terms
    end
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

  def purchase_terms
    self.terms_type == 'Days' ? "#{self.terms || 0} - Days" : self.terms_type
  end

  def perform_calculations
    sum_amount = stocks.sum(:amount)
    self.update_column(:total_amount, sum_amount)
    # Now Tax
    tax_per = self.tax.tax_percentage rescue 0
    self.update_column(:tax_amount, sum_amount * ( tax_per.to_f / 100.0))
    #Update pending amount as well
    total_paid = self.payments.sum(:amount)
    pending_amount = [(total_amount.to_d - total_paid.to_d), 0].max
    self.update_column(:pending_amount, pending_amount)
  end

end
