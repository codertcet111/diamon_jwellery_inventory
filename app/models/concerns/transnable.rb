module Transnable
  extend ActiveSupport::Concern
  included do
    has_many :transactions, :as => :transnable
    has_many :ledger_financial_records, :as => :ledgerable
  end
end