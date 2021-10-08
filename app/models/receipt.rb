class Receipt < ApplicationRecord

  belongs_to :party, inverse_of: :receipts
  belongs_to :sale, inverse_of: :receipts

  enum receipt_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount

  def update_pending_amount
    sum_amount = sale.final_amount
    total_paid = sale.receipts.sum(:amount)
    pending_amount = [(sum_amount.to_d - total_paid.to_d), 0].max
    sale.update_column(:pending_amount, pending_amount)
  end

  rails_admin do
    edit do
      field :receipt_mode do
        required true
      end
      field :date do
        required true
      end
      field :amount do
        required true
      end
      field :party do
        required true
      end
      field :sale do
        required true
      end
      include_all_fields
    end
  end

end