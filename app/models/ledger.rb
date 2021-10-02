class Ledger < ApplicationRecord
  belongs_to :ledger_group

  rails_admin do
    navigation_label Proc.new { "Ledger" }
  end
end
