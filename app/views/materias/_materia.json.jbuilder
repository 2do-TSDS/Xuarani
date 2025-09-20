json.extract! materia, :id, :nombre, :turno_id, :curso_id, :orientacion_id, :ciclo_lectivo_id, :created_at, :updated_at
json.url materia_url(materia, format: :json)
