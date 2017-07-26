json.extract! user_data, :id, :username, :data, :created_at, :updated_at
json.url user_data_url(user_data, format: :json)
