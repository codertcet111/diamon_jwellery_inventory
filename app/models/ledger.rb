class Ledger < ApplicationRecord
  include Transnable
  belongs_to :ledger_group
  has_many :to_contras, :class_name => "Contra", :foreign_key => "ledger_1_id"
  has_many :from_contras, :class_name => "Contra", :foreign_key => "ledger_2_id"
  has_many :to_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "ledger_1_id"
  has_many :from_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "ledger_2_id"
  has_many :payments
  has_many :receipts
  STOCK_LEDGER_NAME = "Stock Ledger"

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    show do
    	exclude_fields :address
    	field :ledger_address
      exclude_fields :transactions
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
    end
    edit do
      exclude_fields :transactions
      exclude_fields :payments
      exclude_fields :receipts
    end
  end

  def self.stock_ledger
    Ledger.find_or_create_by_name(STOCK_LEDGER_NAME)
  end

  def ledger_address_short
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def ledger_address
  	self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end
end
