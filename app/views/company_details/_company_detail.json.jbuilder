json.extract! company_detail, :id, :name, :gst, :address, :pan_card, :adhaar, :mobile_number, :qbc_no, :created_at, :updated_at
json.url company_detail_url(company_detail, format: :json)
