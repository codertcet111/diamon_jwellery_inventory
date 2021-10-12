class Purchase < ApplicationRecord
  # NOTES: -> below
  # total_amount : amount without any calculation
  # discount_amount : Discount amount
  # tax amount : tax amount on (total_amount - discount_amount)
  # final amount : after applying all disc, tax
  belongs_to :party
  belongs_to :broker, optional: true
  has_many :stocks, inverse_of: :purchase, dependent: :destroy
  has_many :payments, inverse_of: :purchase, dependent: :destroy
  has_many :purchases_taxes
  has_many :taxes, through: :purchases_taxes

  enum terms_type: ["Days","COD","Advance"]
  accepts_nested_attributes_for :stocks
  accepts_nested_attributes_for :payments
  accepts_nested_attributes_for :purchases_taxes

  after_create :perform_calculations
  after_update :recalculate_pending_amount

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
    exclude_fields :purchases_taxes
    exclude_fields :total_amount
   end
  end

  def purchase_terms
    self.terms_type == 'Days' ? "#{self.terms || 0} - Days" : self.terms_type
  end

  def perform_calculations
    sum_amount = stocks.sum(:amount).to_f
    self.update_column(:total_amount, sum_amount)
    # then do tax calculation
    amount_eligible_for_tax = sum_amount.to_f - discount_amount.to_f
    i_tax_amount = 0.0
    self.taxes.each do |i_tax|
      tax_per = i_tax.tax_percentage rescue 0
      i_tax_amount += amount_eligible_for_tax * ( tax_per.to_f / 100.0)
    end
    self.update_column(:tax_amount, i_tax_amount.to_f)
    i_final_amount = (sum_amount.to_f - discount_amount.to_f) + i_tax_amount.to_f
    self.update_column(:final_amount, i_final_amount)
    self.update_pending_amount
    self.calculate_brokerage
  end

  def calculate_brokerage
    final_amount_including_tax = self.final_amount.to_f + self.tax_amount.to_f
    brokerage_calculated = final_amount_including_tax * (broker_percentage.to_f / 100.0)
    self.update_column(:broker_amount, brokerage_calculated)
  end

  def update_pending_amount
    total_paid = self.payments.sum(:amount) rescue 0.0
    pending_amount = [(final_amount.to_d - total_paid.to_d), 0].max
    self.update_column(:pending_amount, pending_amount)
  end

  def amount_taxable
    self.total_amount.to_f - discount_amount.to_f
  end

  def recalculate_pending_amount
    if saved_change_to_final_amount?
      update_pending_amount
      calculate_brokerage
    end  
  end

end
