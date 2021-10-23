class Brokerage < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :sale, optional: true
  belongs_to :broker
  belongs_to :ledger
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  after_create :create_transactions
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
