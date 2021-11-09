class Brokerage < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :sale, optional: true
  belongs_to :broker
  belongs_to :ledger
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  after_commit :create_transactions, on: :create
  after_commit :update_sale_or_purchase
  has_many :brokerages_taxes
  has_many :taxes, through: :brokerages_taxes
  accepts_nested_attributes_for :brokerages_taxes, allow_destroy: :true

  def create_transactions
  	# Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.amount, transaction_date: self.payment_date, transnable: self.broker, invoice_number: (purchase || sale).try(:invoice_number), invoicable: (purchase || sale))
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.amount, transaction_date: self.payment_date, transnable: Ledger.cash_ledger, invoice_number: (purchase || sale).try(:invoice_number), invoicable: (purchase || sale))
  end

  def update_sale_or_purchase
    if self.purchase
      updated_brokerage_paid = self.purchase.brokerages.sum(&:amount)
      self.purchase.update_columns(brokerage_paid_amount: updated_brokerage_paid, is_brokerage_paid: updated_brokerage_paid >= self.purchase.broker_amount.to_f)
    elsif self.sale
      updated_brokerage_paid = self.sale.brokerages.sum(&:amount)
      self.sale.update_columns(brokerage_paid_amount: updated_brokerage_paid, is_brokerage_paid: updated_brokerage_paid >= self.sale.broker_amount.to_f)
    end 
  end

  rails_admin do
    navigation_label Proc.new { "I: Inventory Managment" }
  	include_all_fields
    field :ledger do
      label "From Ledger"
    end
    edit do
      fields do
        help " <br>".html_safe
      end
    	exclude_fields :brokerages_taxes
    end
  end
end
