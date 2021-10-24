class FinancialYear < ApplicationRecord
  class << self
    # To RUN ON 1st APRIL 1:00 AM
    def financial_year_closing_script
      date_range = current_financial_year_range
      previous_financial_year = FinancialYear.order(:end_date).last
      new_financial_year = FinancialYear.find_or_create_by(start_date: date_range.first, end_date: date_range.last, name: "#{date_range.first.year}-#{date_range.last.year}")
      Party.all.each do |entity|
        create_or_update_entity_closing_for_year(entity, previous_financial_year, new_financial_year)
      end
      Ledger.all.each do |entity|
        create_or_update_entity_closing_for_year(entity, previous_financial_year, new_financial_year)
      end
      Broker.all.each do |entity|
        create_or_update_entity_closing_for_year(entity, previous_financial_year, new_financial_year)
      end
    end

    def create_or_update_entity_closing_for_year(entity, previous_financial_year, new_financial_year)
      previous_ledger_financial_entry = LedgerFinancialRecord.find_by(financial_year: previous_financial_year, ledgerable: entity)
      new_ledger_financial_entry = LedgerFinancialRecord.find_or_create_by(financial_year: new_financial_year, ledgerable: entity)
      if previous_ledger_financial_entry.present?
        last_transaction_closing_balance = entity.transactions.order(:transaction_date).last.try(:closing_balance).to_d rescue 0.0
        previous_ledger_financial_entry.update_columns(closing_balance: last_transaction_closing_balance)
        new_ledger_financial_entry.update_columns(opening_balance: last_transaction_closing_balance, closing_balance: 0.0)
      else
        new_ledger_financial_entry.update_columns(opening_balance: 0.0, closing_balance: 0.0)
      end
    end

    def current_financial_year_range
      date = Time.now
      date = date.change(year: date.year - 1) if date.month < 4
      date = date.change(month: 4).beginning_of_month
      (date .. (date + 1.year - 1.day).end_of_day)
    end
  end
end


# 1st April 2021
# create 2021 - 2022
# fetch 2020 - 2021
# loop each ledgers
#   fetch existing ledgerFinancialYear,
#   update closing balance as last transactions closing balance
#   create  this ledgerFinancialYear with 2021 - 2022
#   update its opening balance
# end
# create financial year entry 
# Get existing finanncial year record
# each loop for all ledgers
#   create ledgerFinancialYear entry
#   fetch last transaction's closing balance and update to above object opening balance
#   and closing balance of previous years ledgerFinancialYear record
# end