json.extract! connector, :id, :box_id, :aws_conn_id, :code, :url, :power, :voltage, :i_max, :price_per_kWh, :current_user, :frequency, :status, :created_at, :updated_at
json.url connector_url(connector, format: :json)
