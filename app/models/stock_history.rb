class StockHistory < ApplicationRecord

  belongs_to :stock

  rails_admin do
    visible false
  end

end
