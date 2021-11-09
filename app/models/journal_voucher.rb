class JournalVoucher < ApplicationRecord
  belongs_to :ledger_1, :class_name => "Ledger", optional: true
  belongs_to :ledger_2, :class_name => "Ledger", optional: true
  belongs_to :party_1, :class_name => "Party", optional: true
  belongs_to :party_2, :class_name => "Party", optional: true

  rails_admin do
    navigation_label Proc.new { "B: Entry" }
    include_all_fields
    field :ledger_1 do
      label 'Ledger To'
      required false
    end
    field :ledger_2 do
      label 'Ledger From'
      required false
    end
    field :party_1 do
      label 'Party To'
      required false
    end
    field :party_2 do
      label 'Party From'
      required false
    end
    edit do
      fields do
        help " <br>".html_safe
      end
    end
  end
end
