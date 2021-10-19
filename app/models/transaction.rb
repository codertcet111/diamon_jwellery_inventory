class Transaction < ApplicationRecord
  belongs_to :transnable, :polymorphic => true
  enum transaction_type: ["Debit","Credit"]


  rails_admin do
    label 'Transaction'
    edit do
      include_all_fields
    end
  end

  def amount
    self.transaction_type == Transaction.transaction_type["Debit"] ? self.debit_amount : self.credit_amount
  end
end
