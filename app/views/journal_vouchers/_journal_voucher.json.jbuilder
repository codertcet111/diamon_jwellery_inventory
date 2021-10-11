json.extract! journal_voucher, :id, :amount, :date, :notes, :created_at, :updated_at
json.url journal_voucher_url(journal_voucher, format: :json)
