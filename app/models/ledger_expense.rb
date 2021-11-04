class LedgerExpense < ApplicationRecord
  include Invoicable
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  belongs_to :ledger
  has_many :ledger_expenses_taxes
  has_many :taxes, through: :ledger_expenses_taxes
  accepts_nested_attributes_for :ledger_expenses_taxes, allow_destroy: :true
  after_commit :calculate_tax, :generate_invoice_if_not, :create_transactions, on: :create

  def create_transactions
    # Transaction for ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.amount, transaction_date: self.date, transnable: self.ledger, invoice_number: self.invoice_number, invoicable: self)
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.amount, transaction_date: self.date, transnable: Ledger.cash_ledger, invoice_number: self.invoice_number, invoicable: self)
  end

  def calculate_tax
    amount_eligible_for_tax = self.amount
    i_tax_amount = 0.0
    self.taxes.each do |i_tax|
      tax_per = i_tax.tax_percentage rescue 0
      i_tax_amount += amount_eligible_for_tax * ( tax_per.to_f / 100.0)
    end
    self.update_columns(tax_amount: i_tax_amount.to_f, final_amount: (self.amount.to_f + i_tax_amount.to_f))
  end

  def display_invoice_number
    "#{self.invoice_number}"
  end

  def generate_invoice_if_not
    self.update_columns(invoice_number: "Expense_00#{self.id}") unless self.invoice_number
  end

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    label "Ledger Expense / Bill Entries"
    edit do
      include_all_fields
      exclude_fields :ledger_expenses_taxes
      exclude_fields :transactions
    end
  end
end
