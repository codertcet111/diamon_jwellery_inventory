class EntryModule < ApplicationRecord
  has_many :transactions
  accepts_nested_attributes_for :transactions
  validate :validate_total_debit_and_credit_equal

  def validate_total_debit_and_credit_equal
    # total_debit == total_credit
    # errors.add(:base, "Total debit and credit should be same")
  end
end
