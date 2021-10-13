class LedgerExpense < ApplicationRecord
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]
  belongs_to :ledger

  rails_admin do
    navigation_label Proc.new { "Ledger" }
  end
end
