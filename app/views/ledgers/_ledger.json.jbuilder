json.extract! ledger, :id, :name, :ledger_group_id, :created_at, :updated_at
json.url ledger_url(ledger, format: :json)
