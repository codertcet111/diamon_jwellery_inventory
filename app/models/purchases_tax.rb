class PurchasesTax < ApplicationRecord
  belongs_to :purchase
  belongs_to :tax
end
