class Receipt < ApplicationRecord

  belongs_to :party, inverse_of: :receipts
  belongs_to :sale, inverse_of: :receipts, optional: true

  enum receipt_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount

  def update_pending_amount
    if sale
      sum_amount = sale.final_amount
      total_paid = sale.receipts.sum(:amount)
      pending_amount = [(sum_amount.to_d - total_paid.to_d), 0].max
      sale.update_column(:pending_amount, pending_amount)
    end
  end

  rails_admin do
    label 'Receipt'
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
      # field :sale do
      #   required true
      # end
      include_all_fields
      exclude_fields :party_come
      exclude_fields :pc_acc_name
      exclude_fields :party_paid
      exclude_fields :pp_acc_name
    end
  end

end