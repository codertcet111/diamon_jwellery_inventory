class BrokeragesTax < ApplicationRecord
  belongs_to :brokerage
  belongs_to :tax
end
