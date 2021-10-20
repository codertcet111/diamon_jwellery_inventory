class Payment < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :payments
  belongs_to :party
  belongs_to :ledger
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount
  after_create :create_transactions

  def name
    "Payment: " + amount.to_s
  end

  def update_pending_amount
    self.purchase.update_pending_amount
  end

  def create_transactions
    '''
    # Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_type["Debit"], debit_amount: self.amount, transaction_date: self.date, transnable: self.party, invoice_number: self.purchase.invoice_number)
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_type["Credit"], credit_amount: self.amount, transaction_date: self.date, transnable: self.ledger, invoice_number: self.purchase.invoice_number)
    '''
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
    field :ledger do
      label "From Ledger"
    end
    exclude_fields :party_come
    exclude_fields :pc_acc_name
    exclude_fields :party_paid
    exclude_fields :pp_acc_name
  end

end
