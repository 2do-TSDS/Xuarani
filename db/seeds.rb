# ==== ROLES ====
roles = ["Administrador", "Preceptor", "Docente", "Alumno"]
roles.each do |role_name|
  Role.find_or_create_by!(nombre: role_name)
end
puts "Roles creados: #{Role.pluck(:nombre).join(', ')}"

# ==== USUARIOS BASE ====
usuarios_base = [
  { email: "admin@demo.com",     pass: "admin123",     role: "Administrador", perfil: { nombres: "Admin",     apellidos: "Sistema",    dni: "10000000", fecha_nacimiento: "1980-01-01", direccion: "Calle Admin 123", telefono: "1111111111" } },
  { email: "preceptor@demo.com", pass: "preceptor123", role: "Preceptor",     perfil: { nombres: "Pedro",    apellidos: "Preceptor",  dni: "20000000", fecha_nacimiento: "1985-02-02", direccion: "Calle Preceptor 456", telefono: "2222222222" } },
  { email: "docente@demo.com",   pass: "docente123",   role: "Docente",       perfil: { nombres: "Diego",    apellidos: "Docente",    dni: "30000000", fecha_nacimiento: "1990-03-03", direccion: "Calle Docente 789", telefono: "3333333333" } },
  { email: "alumno@demo.com",    pass: "alumno123",    role: "Alumno",        perfil: { nombres: "Ana",      apellidos: "Alumno",     dni: "40000000", fecha_nacimiento: "2005-04-04", direccion: "Calle Alumno 101", telefono: "4444444444" } }
]

usuarios_base.each do |attrs|
  user = User.find_or_create_by!(email: attrs[:email]) do |u|
    u.password = attrs[:pass]
    u.password_confirmation = attrs[:pass]
  end

  # Crear perfil si no existe
  unless user.perfil
    user.create_perfil!(attrs[:perfil])
  end

  # Asignar rol
  role = Role.find_by!(nombre: attrs[:role])
  user.roles << role unless user.roles.include?(role)

  puts "Usuario #{attrs[:role]} creado: #{user.email}"
end

# ==== TURNOS ====
["Mañana", "Tarde", "Noche"].each do |t|
  Turno.find_or_create_by!(nombre: t)
end
puts "Turnos creados: #{Turno.pluck(:nombre).join(', ')}"

# ==== CURSOS (1º a 6º) ====
(1..6).each do |n|
  Curso.find_or_create_by!(nombre: "#{n}° Año")
end
puts "Cursos creados: #{Curso.pluck(:nombre).join(', ')}"

# ==== ORIENTACIONES ====
["Ciencias Sociales", "Ciencias Naturales"].each do |o|
  Orientacion.find_or_create_by!(nombre: o)
end
puts "Orientaciones creadas: #{Orientacion.pluck(:nombre).join(', ')}"

# ==== DIVISIONES ====
["A", "B", "C"].each do |d|
  Division.find_or_create_by!(nombre: d)
end
puts "Divisiones creadas: #{Division.pluck(:nombre).join(', ')}"

# ==== CICLO LECTIVO ====
año_actual = Date.today.year
CicloLectivo.find_or_create_by!(año: año_actual) do |c|
  c.inicio = Date.new(año_actual, 3, 1)   # 1 de marzo
  c.final  = Date.new(año_actual, 12, 15) # 15 de diciembre
end
puts "Ciclo lectivo creado: #{CicloLectivo.last.año} (#{CicloLectivo.last.inicio} a #{CicloLectivo.last.final})"
