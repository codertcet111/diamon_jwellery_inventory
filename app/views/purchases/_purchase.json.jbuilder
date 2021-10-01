json.extract! purchase, :id, :stock_primary_id, :purchase_date, :days, :dollar_rate, :bill_present, :pending_amount, :amount, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
