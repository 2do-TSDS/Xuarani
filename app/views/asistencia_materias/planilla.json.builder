# app/views/asistencia_materias/planilla.json.jbuilder

# 1. Información general
json.materia_division do
  json.id @materia_division.id
  json.nombre @materia_division.materia.nombre 
  json.division @materia_division.division.nombre
end

json.cantidad_modulos @cantidad_modulos
json.fecha Date.today

# 2. Array de alumnos (nota: clave "alumnos")
json.alumnos @materia_alumnos do |materia_alumno|
  
  json.id materia_alumno.id # ID de MateriaAlumno

  # 3. Datos anidados del alumno
  json.alumno do
    json.id materia_alumno.alumno.id
    json.nombres materia_alumno.alumno.perfil&.nombres
    json.apellidos materia_alumno.alumno.perfil&.apellidos
  end

  json.asistencias_de_hoy materia_alumno.asistencias_de_hoy do |asistencia|
    json.id asistencia.id
    json.modulo asistencia.modulo
    
    json.parametro do
      json.id asistencia.paramto.id
      json.abreviacion asistencia.parametro.abreviacion
    end
  end
end