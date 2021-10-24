class CompanyDetail < ApplicationRecord
  
  rails_admin do
    navigation_label Proc.new { "Rio Diam" }
    label 'My Company Detail'
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
    show do
      exclude_fields :address
      field :company_address
    end
    list do
      exclude_fields :address
      field :company_address_short do
        label 'Company Address'
      end
    end
  end

  def company_address_short
    self.address.to_s.gsub(/\n/, '<br/>').html_safe.first(10) + "..."
  end

  def company_address
    self.address.to_s.gsub(/\n/, '<br/>').html_safe
  end

end
