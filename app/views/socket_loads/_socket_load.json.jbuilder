json.extract! socket_load, :id, :el_socket_id, :i_current, :voltage, :power, :time, :created_at, :updated_at
json.url socket_load_url(socket_load, format: :json)
