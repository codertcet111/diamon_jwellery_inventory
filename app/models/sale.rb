class Sale < ApplicationRecord

  has_many :sale_items, inverse_of: :sale, dependent: :destroy
  has_many :receipts, inverse_of: :sale, dependent: :destroy
  belongs_to :party
  belongs_to :broker, optional: true
  has_many :sales_taxes
  has_many :taxes, through: :sales_taxes
  enum sale_type: ['LCR', 'Export']
  # enum gst_type: ['CGST & SGST','ISGT']
  # total_amount : amount without any calculation
  # discount_amount : Discount amount
  # tax amount : tax amount on (total_amount - discount_amount)
  # final amount : after applying all disc, tax
  accepts_nested_attributes_for :sale_items
  accepts_nested_attributes_for :receipts
  accepts_nested_attributes_for :sales_taxes

  after_create :perform_calculations

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
      field :sale_type do
        required true
      end
      exclude_fields :pending_amount
      exclude_fields :receipts
      exclude_fields :tax_amount
      exclude_fields :total_amount
      exclude_fields :tax
      exclude_fields :sales_taxes
      exclude_fields :final_amount
    end
    include_all_fields
    field :terms do
      label 'Terms (In Days)'
    end
  end

  def perform_calculations
    # first calculate total amount
    sum_amount = sale_items.sum(:amount)
    self.update_column(:total_amount, sum_amount)
    # then do tax calculation
    amount_eligible_for_tax = sum_amount.to_f - discount_amount.to_f
    i_tax_amount = 0.0
    self.taxes.each do |i_tax|
      tax_per = i_tax.tax_percentage rescue 0
      i_tax_amount += amount_eligible_for_tax * ( tax_per.to_f / 100.0)
    end
    self.update_column(:tax_amount, i_tax_amount)
    i_final_amount = (sum_amount - discount_amount) + i_tax_amount
    self.update_column(:final_amount, i_final_amount)
    self.update_pending_amount
  end

  def update_pending_amount
    total_paid = self.receipts.sum(:amount) rescue 0.0
    pending_amount = [(final_amount.to_d - total_paid.to_d), 0].max
    self.update_column(:pending_amount, pending_amount)
  end

  def amount_taxable
    self.total_amount.to_f - discount_amount.to_f
  end

  def current_financial_year
    year_range(current_financial_year_start)
  end

  def previous_financial_year
    year_range(current_financial_year_start - 1.year)
  end

  def current_financial_year_start
    date = self.sale_date
    date.change(year: date.year - 1) if date.month < 4
    date.change(month: 4).beginning_of_month
  end

  def year_range(date)
    (date.year .. (date + 1.year - 1.day).year).to_s.sub('..','-')
  end

end