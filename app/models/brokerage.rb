class Brokerage < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :sale, optional: true
  belongs_to :broker
  belongs_to :ledger
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  after_create :create_transactions, :update_sale_or_purchase
  has_many :brokerages_taxes
  has_many :taxes, through: :brokerages_taxes
  accepts_nested_attributes_for :brokerages_taxes

  def create_transactions
  	'''
  	# Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.amount, transaction_date: self.payment_date, transnable: self.broker, invoice_number: (purchase || sale).invoice_number)
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.amount, transaction_date: self.payment_date, transnable: self.ledger, invoice_number: (purchase || sale).invoice_number)
    '''
  end

  def update_sale_or_purchase
    if self.purchase
      updated_brokerage_paid = self.purchase.brokerage_paid_amount + self.amount
      self.purchase.update_columns(brokerage_paid_amount: updated_brokerage_paid, is_brokerage_paid: updated_brokerage_paid >= self.purchase.broker_amount.to_f)
    elsif self.sale
      updated_brokerage_paid = self.sale.brokerage_paid_amount + self.amount
      self.sale.update_columns(brokerage_paid_amount: updated_brokerage_paid, is_brokerage_paid: updated_brokerage_paid >= self.sale.broker_amount.to_f)
    end 
  end

  rails_admin do
    navigation_label Proc.new { "B: Entry" }
  	include_all_fields
    field :ledger do
      label "From Ledger"
    end
    edit do
    	exclude_fields :brokerages_taxes
    end
  end
end
