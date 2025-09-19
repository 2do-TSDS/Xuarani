json.extract! parametro, :id, :abreviacion, :nombre, :valor, :created_at, :updated_at
json.url parametro_url(parametro, format: :json)
