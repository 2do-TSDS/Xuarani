json.extract! asistencia_materia, :id, :materia_alumno_id, :parametro_id, :observaciones, :fecha, :modulo, :created_at, :updated_at
json.url asistencia_materia_url(asistencia_materia, format: :json)
