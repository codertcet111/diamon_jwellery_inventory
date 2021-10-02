class LedgerExpense < ApplicationRecord
  belongs_to :ledger

  rails_admin do
    navigation_label Proc.new { "Ledger" }
  end
end
