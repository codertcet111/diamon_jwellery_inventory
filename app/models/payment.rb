class Payment < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :payments
  belongs_to :party
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount

  def name
    "Payment: " + amount.to_s
  end

  def update_pending_amount
    self.purchase.update_pending_amount
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
    exclude_fields :party_come
    exclude_fields :pc_acc_name
    exclude_fields :party_paid
    exclude_fields :pp_acc_name
  end

end
