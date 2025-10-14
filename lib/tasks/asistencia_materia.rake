# lib/tasks/asistencia_materia.rake
# frozen_string_literal: true

namespace :asistencia_mat do
  desc "Crea en bulk AsistenciaMateria del día (por módulo) para cada alumno que cursa HOY, sin pisar existentes."
  task crear_diaria: :environment do
    tz_id  = ENV['TZ'] || (Rails.application.config.time_zone rescue nil) || 'America/Argentina/Buenos_Aires'
    zona   = Time.find_zone!(tz_id)
    fecha  = zona.today
    dia_cw = fecha.cwday

    puts "=================================================="
    puts "Iniciando: AsistenciaMateria del día | Fecha: #{fecha} (cwday=#{dia_cw}, tz=#{tz_id})"

    # 2) Ciclo activo
    ciclo = CicloLectivo.find_by("inicio <= ? AND final >= ?", fecha, fecha)
    unless ciclo
      puts "INFO: No hay ciclo lectivo activo hoy. Nada que hacer."
      exit 0
    end

    # 3) Parámetro inicial (por defecto Presente "P")
    parametro = Parametro.find_by!(abreviacion: ENV.fetch("ASIS_MAT_ABREV", "P"))

    # 4) Cantidad de módulos HOY por MateriaDivision (único md+dia)
    md_cant = Modulo
      .joins(materia_division: { materia: :ciclo_lectivo })
      .where(dia: dia_cw, materias: { ciclo_lectivo_id: ciclo.id })
      .pluck(:materia_division_id, :cantidad)
      .to_h

    if md_cant.empty?
      puts "INFO: No hay módulos configurados para hoy en el ciclo #{ciclo.año}."
      exit 0
    end

    # 5) Todas las inscripciones a esas MateriaDivision
    md_to_ma_ids = MateriaAlumno
      .where(materia_division_id: md_cant.keys)
      .pluck(:materia_division_id, :id)       # [[md_id, ma_id], ...]
      .group_by(&:first)                       # { md_id => [[md_id, ma_id], ...] }
      .transform_values { |pairs| pairs.map(&:last) } # { md_id => [ma_id, ...] }

    if md_to_ma_ids.empty?
      puts "INFO: No hay alumnos inscriptos en las materias con módulos hoy."
      exit 0
    end

    # 6) Inserción en lotes (con timestamps) sin pisar existentes
    ahora            = Time.current
    total_antes      = AsistenciaMateria.where(fecha: fecha).count
    total_intentados = 0
    buffer           = []

    # tamaño de lote prudente (evita límites de parámetros por motor)
    tam_lote = 1_000

    ActiveRecord::Base.transaction do
      md_to_ma_ids.each do |md_id, ma_ids|
        cantidad = md_cant[md_id].to_i
        next if cantidad <= 0

        ma_ids.each do |ma_id|
          1.upto(cantidad) do |n_modulo|
            buffer << {
              materia_alumno_id: ma_id,
              parametro_id:      parametro.id,
              fecha:             fecha,
              modulo:            n_modulo
            }
            total_intentados += 1

            if buffer.size >= tam_lote
              AsistenciaMateria.insert_all(buffer, unique_by: :idx_asist_materia_unica_por_modulo_dia)
              buffer.clear
            end
          end
        end
      end

      AsistenciaMateria.insert_all(buffer, unique_by: :idx_asist_materia_unica_por_modulo_dia) if buffer.any?
    end

    total_despues = AsistenciaMateria.where(fecha: fecha).count
    creados       = total_despues - total_antes

    puts "--------------------------------------------------"
    puts "¡Tarea finalizada!"
    puts "Intentados (teóricos): #{total_intentados}"
    puts "Creados (reales)     : #{creados} (conflictos/ya existentes se omitieron)"
    puts "=================================================="
  end
end
