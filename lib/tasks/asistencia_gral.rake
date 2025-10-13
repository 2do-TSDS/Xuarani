
namespace :asistencia_gral do
  desc "Crea los registros de asistencia general para todos los alumnos activos del ciclo lectivo actual."
  task crear_diaria: :environment do
    log_output = []
    log_output << "=================================================="
    log_output << "Iniciando tarea: Crear Asistencia General Diaria | Fecha: #{Date.today}"

    ciclo_actual = CicloLectivo.find_by("inicio <= ? AND final >= ?", Date.today, Date.today)
    unless ciclo_actual
      puts "ERROR CRÍTICO: No se encontró un ciclo lectivo activo para la fecha de hoy. Tarea abortada."
      exit 0
    end

    parametro_presente = Parametro.find_by(nombre: "Presente")
    unless parametro_presente
      puts "ERROR: No se encontró el Parámetro con abreviación 'P' para 'Presente'. Tarea abortada."
      abort
    end

    alumnos_activos = User.alumnos
                           .joins(materia_alumnos: { materia_division: { materia: :ciclo_lectivo } })
                           .where(ciclo_lectivos: { id: ciclo_actual.id })
                           .distinct

    if alumnos_activos.empty?
      puts "INFO: No se encontraron alumnos activos para registrar asistencia. Tarea finalizada sin acciones."
      exit 0
    end

    creados = 0
    existentes = 0
    errores = []

    alumnos_activos.each do |alumno|
      registro = AsistenciaGeneral.find_or_initialize_by(
        alumno: alumno,
        fecha: Date.today
      )

      if registro.new_record?
        registro.parametro = parametro_presente
        if registro.save
          creados += 1
        else
          errores << "Error al crear para '#{alumno.display_name}': #{registro.errors.full_messages.to_sentence}"
        end
      else
        existentes += 1
      end
    end

    log_output << "--------------------------------------------------"
    if errores.any?
      log_output << "La tarea finalizó con #{errores.count} ERRORES:"
      errores.each { |e| log_output << " - #{e}" }
    else
      log_output << "¡Tarea finalizada con ÉXITO!"
    end

    log_output << "Resumen: Registros creados = #{creados}, Ya existentes = #{existentes}, Errores = #{errores.count}"
    log_output << "=================================================="

    puts log_output.join("\n")
  end
end