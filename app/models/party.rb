class Party < ApplicationRecord
  include Transnable
  has_many :purchases
  has_many :payments
  has_many :sales
  has_many :receipts
  enum party_type: ["Sundry Debitor", "Sundry Creditor"]
  has_many :to_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "party_1_id"
  has_many :from_journal_vouchers, :class_name => "JournalVoucher", :foreign_key => "party_2_id"

  rails_admin do
   edit do
    field :name, :string do
      required true
    end
    field :party_type do
      required true
    end
    include_all_fields
    # field :address do
    #   required true
    # end
    # field :gst_no do
    #   required true
    # end
    # field :pan_no do
    #   required true
    # end
    exclude_fields :sales
    exclude_fields :receipts
    exclude_fields :purchases
    exclude_fields :payments
    exclude_fields :transactions
    exclude_fields :to_journal_vouchers
    exclude_fields :from_journal_vouchers
   end
    show do
      exclude_fields :address
      exclude_fields :transactions
      field :party_address
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
    end
    list do
      exclude_fields :address
      exclude_fields :transactions
      exclude_fields :to_journal_vouchers
      exclude_fields :from_journal_vouchers
      field :party_address_short do
        label 'Party Address'
      end
    end
  end

  def party_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def party_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
