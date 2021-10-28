class Transaction < ApplicationRecord
  belongs_to :transnable, :polymorphic => true, optional: true
  belongs_to :invoicable, :polymorphic => true, optional: true
  belongs_to :entry_module, optional: true
  enum transaction_type: ["Debit","Credit"]
  after_save :save_invoice_number
  after_save :update_closing_balance
  # before_save :mark_transaction_remove


  # def mark_transaction_remove
  #   # Remove unnecessary entries
  #   byebug
  #   transactions.each do |trans|
  #     transactions.mark_for_destruction if trans[:debit_amount] == nil && trans[:credit_amount] == nil && trans[:transaction_date] == nil && trans[:transnable_type] == nil && trans[:transnable_id] == nil && trans[:invoicable_type] == nil && trans[:invoicable_id] == nil
  #   end
  # end

  rails_admin do
    navigation_label Proc.new { "B: Entry" }
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
      end
      field :transnable do
        label "Ledger"
      end
    end
  end

  def save_invoice_number
    self.update_columns(invoice_number: self.invoicable.invoice_number) unless invoice_number
  end

  def update_closing_balance
    last_transaction = Transaction.where(transnable: self.transnable).where('transaction_date < ?', self.transaction_date).order(:transaction_date).last
    last_closing_balance = last_transaction ? last_transaction.try(:closing_balance).to_f : self.transnable.opening_amount.to_f
    closing_balance_amt = last_closing_balance.to_d + debit_amount.to_d - credit_amount.to_d
    self.update_columns(closing_balance: closing_balance_amt)
    self.transnable.update_columns(balance_amount: closing_balance_amt)
    if Transaction.where(transnable: self.transnable).where('transaction_date > ?', self.transaction_date).exists?
      sync_closing_balance_amount
    end
  end

  def sync_closing_balance_amount
    Transaction.where(transnable: self.transnable).where('transaction_date > ?', self.transaction_date).order(:transaction_date).each do |t|
      t.update_closing_balance
    end
  end

  def amount
    self.transaction_type == Transaction.transaction_types["Debit"] ? self.debit_amount : self.credit_amount
  end
end
