json.extract! expense, :id, :type, :amount, :created_at, :updated_at
json.url expense_url(expense, format: :json)
