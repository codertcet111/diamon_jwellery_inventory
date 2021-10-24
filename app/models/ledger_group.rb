class LedgerGroup < ApplicationRecord
  rails_admin do
    navigation_label Proc.new { "Ledger" }
  end
end
