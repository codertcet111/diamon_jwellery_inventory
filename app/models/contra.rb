class Contra < ApplicationRecord
  belongs_to :ledger_1, :class_name => "Ledger"
  belongs_to :ledger_2, :class_name => "Ledger"

  rails_admin do
    include_all_fields
    field :ledger_1 do
      label 'Ledger To'
      required true
    end
    field :ledger_2 do
      label 'Ledger From'
      required true
    end
  end
end
