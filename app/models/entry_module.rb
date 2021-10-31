class EntryModule < ApplicationRecord
  has_many :transactions
  accepts_nested_attributes_for :transactions, allow_destroy: :true
  validate :validate_total_debit_and_credit_equal

  def validate_total_debit_and_credit_equal
    # Do validations
    total_debit_amt = self.transactions.collect(&:debit_amount).compact.sum
    total_credit_amt = self.transactions.collect(&:credit_amount).compact.sum
    unless total_debit_amt == total_credit_amt
      errors.add(:base, "Total debit and credit should be same")
    end
    self.transactions.each do |trans|
      trans.mark_for_destruction if trans[:debit_amount] == nil && trans[:credit_amount] == nil && trans[:transaction_date] == nil && trans[:transnable_type] == nil && trans[:transnable_id] == nil && trans[:invoicable_type] == nil && trans[:invoicable_id] == nil
      if !trans.marked_for_destruction? && trans[:transaction_type] == 'Debit' && (trans[:debit_amount] == 0.0 || trans[:debit_amount] == nil)
        errors.add(:base, "One of the Debit amount is empty, plz correct!")
      elsif !trans.marked_for_destruction? && trans[:transaction_type] == 'Credit'&& (trans[:credit_amount] == 0.0 || trans[:credit_amount] == nil)
        errors.add(:base, "One of the Credit amount is empty, plz correct!")
      end 
    end
  end
  rails_admin do
  	navigation_label Proc.new { "B: Accounts Entry" }
    #the below active is to keep nested form open default
    configure :transactions do
      active true
    end
  	label "Entry Module (Account's entry)"
  end
end
