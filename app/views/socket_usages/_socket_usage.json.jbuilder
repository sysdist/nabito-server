json.extract! socket_usage, :id, :user_id, :el_socket_id, :start_time, :end_time, :kWhs, :amount, :date, :created_at, :updated_at
json.url socket_usage_url(socket_usage, format: :json)
