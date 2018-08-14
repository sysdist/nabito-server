json.extract! transaction, :id, :debtor_id, :creditor_id, :box_id, :connector_id, :kWhs_used, :price_per_kWh, :amount, :date_posted, :begin_time, :end_time, :status, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
