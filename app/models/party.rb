class Party < ApplicationRecord
  include Transnable
  has_many :purchases
  has_many :payments
  has_many :sales
  has_many :receipts
  enum party_type: ["Sundry Debitor", "Sundry Creditor"]
  has_many :to_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "party_1_id"
  has_many :from_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "party_2_id"
  after_commit :create_financial_year_record, on: :create

  scope :sales_outstanding_parties, -> { where(party_type: "Sundry Debitor").joins(:sales).group(:id).having('sum(sales.pending_amount) > 0.0') }
  scope :purchase_outstanding_parties, -> { where(party_type: "Sundry Creditor").joins(:purchases).group(:id).having('sum(purchases.pending_amount) > 0.0') }

  rails_admin do
   navigation_label Proc.new { "Ledger" }
   configure :outstanding_total do
    formatted_value do
      value
    end
   end
   configure :total_payments_made do
    formatted_value do
      value
    end
   end
   configure :total_received_amount do
    formatted_value do
      value
    end
   end
   configure :total_purchases_amount do
    formatted_value do
      value
    end
   end
   configure :total_sales_amount do
    formatted_value do
      value
    end
   end
   edit do
    field :name, :string do
      required true
    end
    field :party_type do
      required true
    end
    include_all_fields
    # field :address do
    #   required true
    # end
    # field :gst_no do
    #   required true
    # end
    # field :pan_no do
    #   required true
    # end
    fields do
      help " <br>".html_safe
    end
    exclude_fields :sales
    exclude_fields :receipts
    exclude_fields :purchases
    exclude_fields :payments
    exclude_fields :transactions
    exclude_fields :to_journal_vouchers
    exclude_fields :from_journal_vouchers
    exclude_fields :outstanding_total
    exclude_fields :total_payments_made
    exclude_fields :total_received_amount
    exclude_fields :total_purchases_amount
    exclude_fields :total_sales_amount
   end
    show do
      exclude_fields :address
      exclude_fields :transactions
      field :party_address
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
    end
    list do
      field :outstanding_total
      field :total_purchases_amount
      field :total_payments_made
      field :total_sales_amount
      field :total_received_amount
      exclude_fields :address
      exclude_fields :transactions
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
      include_all_fields
      field :party_address_short do
        label 'Party Address'
      end
    end
  end

  def outstanding_total
    purchases_pending = self.purchases.sum(:pending_amount) rescue 0.0
    sales_pending = self.sales.sum(:pending_amount) rescue 0.0
    purchases_pending + sales_pending
  end

  def total_payments_made
    self.payments.sum(:amount) rescue 0.0
  end

  def total_received_amount
    self.receipts.sum(:amount) rescue 0.0
  end

  def total_purchases_amount
    self.purchases.sum(:final_amount) rescue 0.0
  end

  def total_sales_amount
    self.sales.sum(:final_amount) rescue 0.0
  end

  def create_financial_year_record
    current_year = FinancialYear.order(:start_date).last
    LedgerFinancialRecord.find_or_create_by(financial_year: current_year, ledgerable: self, opening_balance: 0.0, closing_balance: 0.0)
  end

  def party_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def party_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
