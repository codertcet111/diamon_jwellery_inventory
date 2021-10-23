class LedgerFinancialRecord < ApplicationRecord

  belongs_to :ledgerable, polymorphic: true
  belongs_to :financial_year

end