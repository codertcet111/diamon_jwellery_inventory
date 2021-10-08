class CompanyDetail < ApplicationRecord
  
  rails_admin do
    include_all_fields
    field :gst do
      label 'GST Number'
    end
    field :address do
      label 'Company Address'
    end
    field :pan_card do
      label 'Pan Card Number'
    end
    field :gst do
      label 'GST Number'
    end
    field :adhaar do
      label 'Adhaar Number'
    end
  end
end
