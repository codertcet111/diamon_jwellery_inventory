class LedgerExpensesTax < ApplicationRecord
  belongs_to :ledger_expense
  belongs_to :tax
end
