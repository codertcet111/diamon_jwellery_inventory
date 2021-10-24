json.extract! ledger_expense, :id, :title, :ledger_id, :amount, :notes, :payment_notes, :created_at, :updated_at
json.url ledger_expense_url(ledger_expense, format: :json)
