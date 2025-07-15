json.extract! persona, :id, :nombres, :apellidos, :dni, :fecha_nacimiento, :direccion, :telefono, :email, :created_at, :updated_at
json.url persona_url(persona, format: :json)
