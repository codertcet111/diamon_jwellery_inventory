class Sale < ApplicationRecord

  has_many :sale_items, inverse_of: :sale, dependent: :destroy
  has_many :receipts, inverse_of: :sale, dependent: :destroy
  belongs_to :party
  belongs_to :broker, optional: true
  belongs_to :tax, optional: true
  enum sale_type: ['LCR', 'Export']
  # enum gst_type: ['CGST & SGST','ISGT']

  accepts_nested_attributes_for :sale_items
  accepts_nested_attributes_for :receipts

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
      exclude_fields :pending_amount
      exclude_fields :receipts
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
    tax_per = self.tax.tax_percentage rescue 0
    self.update_column(:tax_amount, sum_amount * ( tax_per.to_f / 100.0))
  end

end