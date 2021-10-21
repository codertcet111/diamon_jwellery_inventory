class Transaction < ApplicationRecord
  belongs_to :transnable, :polymorphic => true
  belongs_to :invoicable, :polymorphic => true
  belongs_to :entry_module, optional: true
  enum transaction_type: ["Debit","Credit"]
  after_save :save_invoice_number

  rails_admin do
    label 'Transaction'
    show do
      include_all_fields
      field :transnable do
        label "Ledger"
      end
      field :invoicable do
        label "Against (Purchase/Sale/Expense)"
      end
    end
    list do
      include_all_fields
      field :transnable do
        label "Ledger"
      end
      field :invoicable do
        label "Against (Purchase/Sale/Expense)"
      end
    end
    edit do
      include_all_fields
      exclude_fields :entry_module
      exclude_fields :invoice_number
      field :invoicable do
        label "Invoice"
        required true
      end
      field :transnable do
        label "Ledger"
        required true
      end
    end
  end

  def save_invoice_number
    self.update_columns(invoice_number: self.invoicable.invoice_number)
  end

  def amount
    self.transaction_type == Transaction.transaction_type["Debit"] ? self.debit_amount : self.credit_amount
  end
end
