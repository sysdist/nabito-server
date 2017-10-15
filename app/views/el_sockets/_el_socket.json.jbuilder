json.extract! el_socket, :id, :user_id, :code, :url, :address, :gps_lat, :gps_lng, :voltage, :i_limit, :price_per_kWh, :in_use, :current_user, :created_at, :updated_at
json.url el_socket_url(el_socket, format: :json)
