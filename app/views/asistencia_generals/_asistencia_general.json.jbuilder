json.extract! asistencia_general, :id, :alumno_id, :parametro_id, :observaciones, :fecha, :created_at, :updated_at
json.url asistencia_general_url(asistencia_general, format: :json)
