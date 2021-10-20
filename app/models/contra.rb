class Contra < ApplicationRecord
  # Contra means internal cash flow, from bank to cash or cash to bank or bank to bank
  # ledger to means, debit
  # ledger from means, credit
  belongs_to :ledger_1, :class_name => "Ledger"
  belongs_to :ledger_2, :class_name => "Ledger"
  after_create :create_transactions

  def create_transactions
    # Transaction for ledger to (ledger_1)
    Transaction.create(transaction_type: Transaction.transaction_type["Debit"], debit_amount: self.amount, transaction_date: self.date, transnable: self.ledger_1, invoice_number: self.id)
    # Transaction for ledger from (ledger_2)
    Transaction.create(transaction_type: Transaction.transaction_type["Credit"], credit_amount: self.amount, transaction_date: self.date, transnable: self.ledger_2, invoice_number: self.id)
  end

  rails_admin do
    include_all_fields
    field :ledger_1 do
      label 'Ledger To'
      required true
    end
    field :ledger_2 do
      label 'Ledger From'
      required true
    end
  end
end
