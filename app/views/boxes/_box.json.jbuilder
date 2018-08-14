json.extract! box, :id, :user_id, :code, :type, :power, :description, :url, :address, :gps_lat, :gps_lng, :status, :created_at, :updated_at
json.url box_url(box, format: :json)
