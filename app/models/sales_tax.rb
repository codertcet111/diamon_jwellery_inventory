class SalesTax < ApplicationRecord
  belongs_to :sale
  belongs_to :tax
end
