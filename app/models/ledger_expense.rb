class LedgerExpense < ApplicationRecord
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  belongs_to :ledger
  has_many :ledger_expenses_taxes
  has_many :taxes, through: :ledger_expenses_taxes
  accepts_nested_attributes_for :ledger_expenses_taxes
  after_create :calculate_tax

  def calculate_tax
    amount_eligible_for_tax = self.amount
    i_tax_amount = 0.0
    self.taxes.each do |i_tax|
      tax_per = i_tax.tax_percentage rescue 0
      i_tax_amount += amount_eligible_for_tax * ( tax_per.to_f / 100.0)
    end
    self.update_column(:tax_amount, i_tax_amount.to_f)
  end

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    edit do
      include_all_fields
      exclude_fields :ledger_expenses_taxes
    end
  end
end
