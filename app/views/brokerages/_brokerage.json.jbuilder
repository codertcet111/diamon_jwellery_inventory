json.extract! brokerage, :id, :amount, :payment_mode, :cheque_number, :broker_id, :notes, :created_at, :updated_at
json.url brokerage_url(brokerage, format: :json)
