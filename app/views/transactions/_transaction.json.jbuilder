json.extract! transaction, :id, :transaction_type, :debit_amount, :credit_amount, :transaction_date, :notes, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
