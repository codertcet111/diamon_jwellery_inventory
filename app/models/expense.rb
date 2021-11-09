class Expense < ApplicationRecord
  belongs_to :stock
  enum expense_type: [:factory, :lab, :angadia, :miscellaneous]

  rails_admin do
    navigation_label Proc.new { "S: Stock" }
    label 'Stock Expenses'
    field :expense_type do
      required true
    end
    field :amount do
      required true
    end
    include_all_fields
    field :stock do
      required true
      inline_add false
      inline_edit false
    end
    edit do
      fields do
        help " <br>".html_safe
      end
    end
  end
end
