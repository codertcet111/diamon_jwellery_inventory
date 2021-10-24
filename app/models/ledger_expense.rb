class LedgerExpense < ApplicationRecord
  include Invoicable
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  belongs_to :ledger
  has_many :ledger_expenses_taxes
  has_many :taxes, through: :ledger_expenses_taxes
  accepts_nested_attributes_for :ledger_expenses_taxes, allow_destroy: :true
  after_commit :calculate_tax, on: :create

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
