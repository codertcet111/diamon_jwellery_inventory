class Broker < ApplicationRecord
  include Transnable
  has_many :purchases
  has_many :sales
  has_many :brokerages
  after_commit :create_financial_year_record, on: :create

  rails_admin do
    navigation_label Proc.new { "Ledger" }
    show do
      exclude_fields :address
      field :broker_address
      exclude_fields :transactions
    end
    list do
      exclude_fields :address
      exclude_fields :transactions
      field :broker_address_short do
        label 'Broker Address'
      end
    end
   edit do
    field :name, :string do
      required true
    end
    field :mobile, :integer do
      required true
    end
    include_all_fields
    fields do
      help " <br>".html_safe
    end
    exclude_fields :sales
    exclude_fields :purchases
    exclude_fields :brokerages
    exclude_fields :transactions
   end
  end

  def create_financial_year_record
    current_year = FinancialYear.order(:start_date).last
    LedgerFinancialRecord.find_or_create_by(financial_year: current_year, ledgerable: self, opening_balance: 0.0, closing_balance: 0.0)
  end

  def broker_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def broker_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
