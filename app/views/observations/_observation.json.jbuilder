json.extract! observation, :id, :name, :observed, :created_at, :updated_at
json.url observation_url(observation, format: :json)
