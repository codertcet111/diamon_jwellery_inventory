class StockPcRange < ApplicationRecord
  has_many :stocks

  rails_admin do
    include_all_fields
    field :name do
      label 'Range'
      required true
    end
    field :min_value do
      label 'Minimum value (Rs)'
      required false
    end
    field :max_value do
      label 'Maximum value (Rs)'
      required false
    end
    exclude_fields :stocks
  end
end
