class Payment < ApplicationRecord
  belongs_to :purchase, optional: true, inverse_of: :payments
  belongs_to :party
  belongs_to :ledger, optional: true
  enum payment_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount
  after_update :update_prev_pending_amount
  after_commit :create_transactions, on: :create
  after_destroy :update_pending_amount

  def name
    "Payment: " + amount.to_s
  end

  def update_pending_amount
    self.purchase.update_pending_amount if self.purchase
  end

  def update_prev_pending_amount
    if saved_change_to_purchase_id?
      prev_purchase_id = previous_changes[:purchase_id][0] rescue nil
      if prev_purchase = Purchase.where(id: prev_purchase_id).last  
        prev_purchase.update_pending_amount
      end
    end
  end

  def create_transactions
    # Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.amount, transaction_date: self.date, transnable: self.party, invoice_number: self.purchase.try(:invoice_number), invoicable: self.purchase)
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.amount, transaction_date: self.date, transnable: Ledger.cash_ledger, invoice_number: self.purchase.try(:invoice_number), invoicable: self.purchase)
  end

  rails_admin do
    navigation_label Proc.new { "I: Inventory Managment" }
    # field :payment_mode do
    #   required true
    # end
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
      inline_add false
      inline_edit false
    end
    field :ledger do
      label "From Ledger"
    end
    edit do
      fields do
        help " <br>".html_safe
      end
      exclude_fields :party_come
      exclude_fields :pc_acc_name
      exclude_fields :party_paid
      exclude_fields :pp_acc_name
      exclude_fields :ledger
      exclude_fields :payment_mode
    end
  end

end
