class Sale < ApplicationRecord
  include Invoicable
  has_many :sale_items, inverse_of: :sale, dependent: :destroy
  has_many :receipts, inverse_of: :sale, dependent: :destroy
  belongs_to :party
  belongs_to :broker, optional: true
  has_many :sales_taxes
  has_many :taxes, through: :sales_taxes
  has_many :brokerages
  enum sale_type: ['LCR', 'Export']
  enum terms_type: ["Days","COD","Advance"]
  # enum gst_type: ['CGST & SGST','ISGT']
  # NOTES: -> below
  # total_amount : amount without any calculation
  # discount_amount : Discount amount
  # tax amount : tax amount on (total_amount - discount_amount)
  # final amount : after applying all disc, tax
  accepts_nested_attributes_for :sale_items
  accepts_nested_attributes_for :receipts
  accepts_nested_attributes_for :sales_taxes

  after_create :perform_calculations, :generate_invoice, :create_transactions
  after_update :recalculate_pending_amount, :create_transactions

  rails_admin do
    navigation_label Proc.new { "B: Entry" }
    show do
      exclude_fields :terms, :terms_type
      field :sales_terms
    end
    list do
      exclude_fields :terms, :terms_type
      field :sales_terms
    end
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
      field :party do
        required true
      end
      field :sale_type do
        required true
      end
      include_all_fields
      exclude_fields :pending_amount
      exclude_fields :receipts
      exclude_fields :tax_amount
      exclude_fields :total_amount
      exclude_fields :tax
      exclude_fields :sales_taxes
      exclude_fields :invoice_number
      exclude_fields :invoice_date
      exclude_fields :brokerages
      exclude_fields :transactions
    end
    include_all_fields
    field :terms do
      label 'Terms (In Days)'
    end
  end

  def display_invoice_number
    "#{self.invoice_number}"
  end

  def sales_terms
    self.terms_type == 'Days' ? "#{self.terms || 0} - Days" : self.terms_type
  end

  def generate_invoice
    rand_invoice = "000#{self.id}"
    self.update_columns(invoice_number: rand_invoice)
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
    self.calculate_brokerage
  end

  def calculate_brokerage
    final_amount_including_tax = self.final_amount.to_f
    brokerage_calculated = final_amount_including_tax * (broker_percentage.to_f / 100.0)
    self.update_column(:broker_amount, brokerage_calculated)
  end

  def update_pending_amount
    total_paid = self.receipts.sum(:amount) rescue 0.0
    i_pending_amount = [(final_amount.to_d - total_paid.to_d), 0].max
    self.pending_amount = i_pending_amount
    self.is_payment_completed = i_pending_amount.to_f <= 0
    self.save
  end

  def create_transactions
    '''
    # Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.final_amount, transaction_date: self.sale_date, transnable: self.party, invoice_number: self.invoice_number)
    # Transaction for Stock
    # IMP: Check and change the final_amount that need to update
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.final_amount, transaction_date: self.sale_date, transnable: Ledger.stock_ledger, invoice_number: self.invoice_number)
    # Transaction for Broker
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.broker_amount, transaction_date: self.sale_date, transnable: self.broker, invoice_number: self.invoice_number)
    '''
  end

  # if_final_amount_changed
  def update_transactions
    '''
    # Update Transaction for Party
    party_transaction = Transaction.find_by(transaction_type: Transaction.transaction_types["Debit"], transnable: self.party, invoice_number: self.invoice_number)
    party_transaction.update_columns(debit_amount: self.final_amount)
    # Update Transaction for Stock
    stock_transaction = Transaction.find_by(transaction_type: Transaction.transaction_types["Credit"], transnable: Ledger.stock_ledger, invoice_number: self.invoice_number)
    stock_transaction.update_columns(credit_amount: self.final_amount)
    # Update Transaction for Broker
    broker_transaction = Transaction.find_by(transaction_type: Transaction.transaction_types["Credit"], transnable: self.broker, invoice_number: self.invoice_number)
    broker_transaction.update_columns(credit_amount: self.broker_amount)
    '''
  end

  def recalculate_pending_amount
    if saved_change_to_final_amount?
      update_pending_amount
      calculate_brokerage
      update_transactions
    end
    if saved_change_to_broker_percentage?
      calculate_brokerage
      update_transactions
    end
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