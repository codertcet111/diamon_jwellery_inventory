class Receipt < ApplicationRecord

  belongs_to :party, inverse_of: :receipts
  belongs_to :sale, inverse_of: :receipts, optional: true
  belongs_to :ledger

  enum receipt_mode: [:cash,:cheque,:angadia,:rtgs_neft, :other]

  after_commit :update_pending_amount, on: :create
  after_commit :create_transactions, on: :create
  after_commit :update_callbacks, on: :update

  def update_pending_amount
    if sale
      self.sale.update_pending_amount
    end
  end

  def create_transactions
    '''
    # Transaction for Party
    Transaction.create(transaction_type: Transaction.transaction_types["Credit"], credit_amount: self.amount, transaction_date: self.date, transnable: self.party, invoice_number: self.sale.invoice_number)
    # Transaction for Bank/Cash ledger
    Transaction.create(transaction_type: Transaction.transaction_types["Debit"], debit_amount: self.amount, transaction_date: self.date, transnable: self.ledger, invoice_number: self.sale.invoice_number)
    '''
  end

  rails_admin do
    navigation_label Proc.new { "B: Entry" }
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
      field :ledger do
        label "To Ledger (Bank / Cash)"
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
    include_all_fields
    field :ledger do
      label "To Ledger"
    end
  end

  def update_callbacks
    if saved_change_to_sale_id?
      self.sale.update_pending_amount
    end
  end

end