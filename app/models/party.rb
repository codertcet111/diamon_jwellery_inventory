class Party < ApplicationRecord
  has_many :purchases
  has_many :payments
  has_many :sales
  has_many :receipts

  rails_admin do
   edit do
    field :name, :string do
      required true
    end
    # field :mobile, :integer do
    #   required true
    # end
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
  end

end
