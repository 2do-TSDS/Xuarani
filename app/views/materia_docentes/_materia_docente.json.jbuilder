json.extract! materia_docente, :id, :materia_division_id, :docente_id, :titular, :created_at, :updated_at
json.url materia_docente_url(materia_docente, format: :json)
