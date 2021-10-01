json.extract! payment, :id, :payment_mode, :date, :amount, :notes, :party_come, :pc_acc_name, :party_paid, :pp_acc_name, :party, :purchase, :created_at, :updated_at
json.url payment_url(payment, format: :json)
