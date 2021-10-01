class Payment < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :payments
  belongs_to :party
  enum payment_mode: [:cash,:cheque,:angadia]

  after_commit :update_pending_amount

  def name
    "Payment: " + amount.to_s
  end

  def update_pending_amount
    sum_amount = purchase.stocks.sum(:amount)
    total_paid = purchase.payments.sum(:amount)
    pending_amount = [(sum_amount.to_d - total_paid.to_d), 0].max
    purchase.update_column(:pending_amount, pending_amount)
  end

  rails_admin do
    field :payment_mode do
      required true
    end
    field :date do
      required true
    end
    field :amount do
      required true
    end
    include_all_fields
    field :party do
      required true
    end
    field :purchase do
      required true
      inline_add false
      inline_edit false
    end
  end

end
