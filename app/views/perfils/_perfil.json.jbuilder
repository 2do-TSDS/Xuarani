json.extract! perfil, :id, :nombres, :apellidos, :dni, :fecha_nacimiento, :direccion, :telefono, :email, :user_id, :created_at, :updated_at
json.url perfil_url(perfil, format: :json)
