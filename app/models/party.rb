class Party < ApplicationRecord
  has_many :purchases
  has_many :payments
  has_many :sales
  has_many :receipts
  enum party_type: ["Sundry Debitor", "Sundry Creditor"]

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
   end
    show do
      exclude_fields :address
      field :party_address
    end
    list do
      exclude_fields :address
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
