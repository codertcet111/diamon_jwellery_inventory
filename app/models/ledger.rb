class Ledger < ApplicationRecord
  include Transnable
  belongs_to :ledger_group
  has_many :to_contras, :class_name => "Contra", :foreign_key => "ledger_1_id"
  has_many :from_contras, :class_name => "Contra", :foreign_key => "ledger_2_id"
  has_many :to_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "ledger_1_id"
  has_many :from_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "ledger_2_id"
  has_many :payments
  has_many :receipts
  after_commit :create_financial_year_record, on: :create
  STOCK_LEDGER_NAME = "Stock Ledger"
  # STOCK_LEDGER_NAME = "STOCK LEDGER"
  CASH_LEDGER_NAME = "CASH ON HAND"
  CASH_LEDGER_NAME_1 = "CASH LEDGER"

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    show do
    	exclude_fields :address
    	field :ledger_address
      exclude_fields :payments
      exclude_fields :receipts
    end
    list do
    	exclude_fields :address
    	field :ledger_address_short do
	      label 'Ledger Address'
	    end
      exclude_fields :transactions
      exclude_fields :payments
      exclude_fields :receipts
      exclude_fields :to_contras
      exclude_fields :from_contras
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
    end
    edit do
      fields do
        help " <br>".html_safe
      end
      exclude_fields :transactions
      exclude_fields :payments
      exclude_fields :receipts
      exclude_fields :to_contras
      exclude_fields :from_contras
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
    end
  end

  def self.cash_ledger
    Ledger.find_by(name: CASH_LEDGER_NAME) || Ledger.find_by(name: CASH_LEDGER_NAME_1)
  end

  def create_financial_year_record
    current_year = FinancialYear.order(:start_date).last
    LedgerFinancialRecord.find_or_create_by(financial_year: current_year, ledgerable: self, opening_balance: self.opening_amount.to_f, closing_balance: 0.0)
  end

  def self.stock_ledger
    Ledger.find_by(name: STOCK_LEDGER_NAME)
  end

  def ledger_address_short
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def ledger_address
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end
end
