# === Helpers ===
def role!(nombre) = Role.find_or_create_by!(nombre: nombre)
def ensure_role!(user, role_name)
  r = role!(role_name)
  user.roles << r unless user.roles.include?(r)
end

def ensure_user!(email:, password:, role_name:, perfil:)
  user = User.find_or_create_by!(email:) do |u|
    u.password = password
    u.password_confirmation = password
  end
  user.create_perfil!(perfil) unless user.perfil
  ensure_role!(user, role_name)
  user
end

def log_section(title)
  puts "\n=== #{title} ==="
end

ActiveRecord::Base.transaction do
  # === ROLES ===
  log_section "ROLES"
  %w[Administrador Preceptor Docente Alumno].each { |r| role!(r) }
  puts "Roles: #{Role.pluck(:nombre).join(', ')}"

  # === USUARIOS BASE ===
  log_section "USUARIOS BASE"
  [
    { email: "admin@demo.com",     password: "admin123",     role: "Administrador",
      perfil: { nombres: "Admin",  apellidos: "Sistema",  dni: "10000000", fecha_nacimiento: "1980-01-01",
                direccion: "Calle Admin 123", telefono: "1111111111" } },
    { email: "preceptor@demo.com", password: "preceptor123", role: "Preceptor",
      perfil: { nombres: "Pedro",  apellidos: "Preceptor", dni: "20000000", fecha_nacimiento: "1985-02-02",
                direccion: "Calle Preceptor 456", telefono: "2222222222" } }
  ].each do |u|
    ensure_user!(email: u[:email], password: u[:password], role_name: u[:role], perfil: u[:perfil])
    puts "Usuario #{u[:role]}: #{u[:email]}"
  end

  # === TURNOS ===
  log_section "TURNOS"
  %w[Mañana Tarde Noche].each { |t| Turno.find_or_create_by!(nombre: t) }
  puts "Turnos: #{Turno.pluck(:nombre).join(', ')}"
  turno_default = Turno.find_by!(nombre: "Mañana")

  # === CURSOS (1º a 6º) ===
  log_section "CURSOS"
  cursos = (1..6).map { |n| Curso.find_or_create_by!(nombre: "#{n}° Año") }
  puts "Cursos: #{Curso.pluck(:nombre).join(', ')}"

  # === ORIENTACIONES ===
  log_section "ORIENTACIONES"
  %w[Ciencias\ Sociales Ciencias\ Naturales].each { |o| Orientacion.find_or_create_by!(nombre: o) }
  orient_sociales  = Orientacion.find_by!(nombre: "Ciencias Sociales")
  orient_naturales = Orientacion.find_by!(nombre: "Ciencias Naturales")
  puts "Orientaciones: #{Orientacion.pluck(:nombre).join(', ')}"

  # === DIVISIONES ===
  log_section "DIVISIONES"
  %w[A B C].each { |d| Division.find_or_create_by!(nombre: d) }
  divisiones = Division.order(:nombre).to_a
  puts "Divisiones: #{divisiones.map(&:nombre).join(', ')}"

  # === CICLO LECTIVO ACTUAL ===
  log_section "CICLO LECTIVO"
  año_actual = Date.today.year
  ciclo = CicloLectivo.find_or_create_by!(año: año_actual) do |c|
    c.inicio = Date.new(año_actual, 3, 1)
    c.final  = Date.new(año_actual, 12, 15)
  end
  puts "Ciclo #{ciclo.año}: #{ciclo.inicio} a #{ciclo.final}"

  # === PARÁMETROS ASISTENCIA (enteros según schema) ===
  log_section "PARÁMETROS ASISTENCIA"
  [
    { abreviacion: "P",    nombre: "Presente",  valor: 0 },
    { abreviacion: "A",    nombre: "Ausente",   valor: 1 },
    { abreviacion: "T",    nombre: "Tarde",     valor: 0.5 }
  ].each do |p|
    Parametro.find_or_create_by!(abreviacion: p[:abreviacion]) do |rec|
      rec.nombre = p[:nombre]
      rec.valor  = p[:valor]
    end
  end
  puts "Parámetros: #{Parametro.pluck(:abreviacion, :nombre).map { |a, n| "#{a}=#{n}" }.join(', ')}"

  # === DOCENTES (pool reutilizable) ===
  log_section "DOCENTES"
  docentes_pool = []
  20.times do |i|
    email = "docente#{i + 1}@demo.com"
    perfil = {
      nombres: "Docente#{i + 1}",
      apellidos: "Demo",
      dni: (30_000_000 + i).to_s,
      fecha_nacimiento: "1980-01-01",
      direccion: "Calle Docente #{i + 1}",
      telefono: "3400#{format('%04d', i)}"
    }
    d = ensure_user!(email:, password: "docente123", role_name: "Docente", perfil:)
    docentes_pool << d
  end
  puts "Docentes pool: #{docentes_pool.size}"

  # === ALUMNOS por Curso/División (12 por combo) ===
  log_section "ALUMNOS"
  alumnos_por_div = {} # key: "1° A" => [User,...]
  cursos.each do |curso|
    divisiones.each do |division|
      grupo_key = "#{curso.nombre} #{division.nombre}"
      alumnos = []
      12.times do |i|
        email  = "alumno-#{curso.nombre.parameterize}-#{division.nombre.downcase}-#{format('%03d', i + 1)}@demo.com"
        perfil = {
          nombres: "Alumno#{i + 1}",
          apellidos: "#{curso.nombre.gsub('°', '')}#{division.nombre}",
          dni: (40_000_000 + rand(1..50_000)).to_s,
          fecha_nacimiento: "2007-01-01",
          direccion: "Calle #{grupo_key}",
          telefono: "11#{rand(1000..9999)}#{rand(1000..9999)}"
        }
        alumnos << ensure_user!(email:, password: "alumno123", role_name: "Alumno", perfil:)
      end
      alumnos_por_div[grupo_key] = alumnos
      puts "Alumnos creados #{grupo_key}: #{alumnos.size}"
    end
  end

  # === MATERIAS (5 por curso) + MateriaDivision (para TODAS las divisiones) ===
  log_section "MATERIAS y MATERIA_DIVISION"
  nombres_base = %w[Matemática Lengua Historia Geografía Biología]

  materias_por_curso = {} # "#{curso.nombre}" => [Materia,...]
  cursos.each_with_index do |curso, idx_curso|
    materias = nombres_base.map.with_index do |nb, i|
      nombre_unico = "#{curso.nombre} - #{nb}" # Materia.nombre es único a nivel global
      Materia.find_or_create_by!(nombre: nombre_unico) do |m|
        m.turno          = turno_default
        m.curso          = curso
        m.orientacion    = (i.even? ? orient_sociales : orient_naturales)
        m.ciclo_lectivo  = ciclo
      end
    end
    materias_por_curso[curso.nombre] = materias
    puts "#{curso.nombre}: #{materias.map(&:nombre).join(', ')}"

    # Crear MateriaDivision para cada división
    divisiones.each do |division|
      materias.each do |materia|
        MateriaDivision.find_or_create_by!(materia:, division:)
      end
    end
  end

  # === Asignar un Docente titular a cada MateriaDivision (ciclo sobre pool) ===
  log_section "DOCENTES por MateriaDivision (titular)"
  md_all = MateriaDivision.includes(:materia, :division).order("materia_id ASC, division_id ASC").to_a
  idx_doc = 0
  md_all.each do |md|
    docente = docentes_pool[idx_doc % docentes_pool.size]
    idx_doc += 1
    MateriaDocente.find_or_create_by!(materia_division: md, docente:) do |mdoc|
      mdoc.titular = true
    end
  end
  puts "MD con titular: #{MateriaDocente.where(titular: true).count} / #{md_all.count}"

  # === Inscribir Alumnos en cada MateriaDivision (8..12 por materia) ===
  log_section "INSCRIPCIONES MateriaAlumno"
  md_all.each do |md|
    grupo_key = "#{md.materia.curso.nombre} #{md.division.nombre}"
    alumnos_grupo = alumnos_por_div.fetch(grupo_key)
    cantidad = rand(8..12)
    seleccion = alumnos_grupo.sample(cantidad)
    seleccion.each do |al|
      MateriaAlumno.find_or_create_by!(materia_division: md, alumno: al)
    end
  end
  total_insc = MateriaAlumno.count
  puts "Total inscripciones MateriaAlumno: #{total_insc}"



  # === MÓDULOS (horario 5h/día lun-vie) ===
  log_section "MÓDULOS (horario 5h/día lun-vie)"
  divisiones.each do |division|
    md_de_division = MateriaDivision.joins(:materia)
                                    .where(division: division)
                                    .order("materias.nombre ASC")
                                    .to_a
    next if md_de_division.empty?

    indice_rotacion = 0
    (1..5).each do |dia_cw| # 1..5 = LUN..VIE
      md_3h = md_de_division[indice_rotacion % md_de_division.size]
      md_2h = md_de_division[(indice_rotacion + 1) % md_de_division.size]
      indice_rotacion += 2

      registro_3h = Modulo.find_or_initialize_by(materia_division: md_3h, dia: dia_cw)
      registro_3h.cantidad = 3
      registro_3h.save!

      registro_2h = Modulo.find_or_initialize_by(materia_division: md_2h, dia: dia_cw)
      registro_2h.cantidad = 2
      registro_2h.save!
    end
  end
  puts "Módulos creados/actualizados: #{Modulo.count}"
end

puts "\n¡Seeds Finalizadas!"
