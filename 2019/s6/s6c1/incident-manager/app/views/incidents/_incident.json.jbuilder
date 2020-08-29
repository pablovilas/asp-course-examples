json.extract! incident, :id, :name, :status, :message, :created_at, :updated_at
json.url incident_url(incident, format: :json)
