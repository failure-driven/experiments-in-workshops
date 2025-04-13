json.extract! message, :id, :body, :name, :created_at, :updated_at
json.url message_url(message, format: :json)
