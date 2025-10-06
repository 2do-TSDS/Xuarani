class MateriasPanelController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    # Tablas Arel descriptivas
    tabla_materias = Materia.arel_table
    tabla_turnos = Turno.arel_table
    tabla_cursos = Curso.arel_table
    tabla_orientaciones = Orientacion.arel_table
    tabla_ciclos_lectivos = CicloLectivo.arel_table
    tabla_divisiones = Division.arel_table
    tabla_usuarios = User.arel_table
    tabla_perfiles = Perfil.arel_table

    # Funciones Arel para ordenar por apellidos/nombres con NULL-safe
    apellidos_coalesce = Arel::Nodes::NamedFunction.new('COALESCE', [tabla_perfiles[:apellidos], Arel::Nodes.build_quoted('')])
    nombres_coalesce = Arel::Nodes::NamedFunction.new('COALESCE', [tabla_perfiles[:nombres],  Arel::Nodes.build_quoted('')])

    # Form Materia + listado
    @materia  = Materia.new
    @materias = Materia
      .eager_load(:turno, :curso, :orientacion, :ciclo_lectivo)
      .order(
        tabla_ciclos_lectivos[:año].asc,
        tabla_orientaciones[:nombre].asc,
        tabla_cursos[:nombre].asc,
        tabla_turnos[:nombre].asc,
        tabla_materias[:nombre].asc
      )
      .load_async

    # Form MateriaDivision + listado
    @materia_division = MateriaDivision.new
    @materia_divisions = MateriaDivision
      .eager_load(materia: :curso, division: {})
      .order(
        tabla_cursos[:nombre].asc,
        tabla_divisiones[:nombre].asc,
        tabla_materias[:nombre].asc
      )
      .load_async
    @materia_divisiones = @materia_divisions 

    # Form MateriaDocente + listado
    @materia_docente  = MateriaDocente.new
    @materia_docentes = MateriaDocente
      .eager_load(
        { docente: :perfil },
        { materia_division: [:division, { materia: [:curso, :ciclo_lectivo] }] }
      ).order(
        tabla_ciclos_lectivos[:año].asc,
        tabla_cursos[:nombre].asc,
        tabla_materias[:nombre].asc,
        tabla_divisiones[:nombre].asc,
        apellidos_coalesce.asc,
        nombres_coalesce.asc,
        tabla_usuarios[:email].asc
      )
      .distinct
      .load_async

    # Form MateriaAlumno + listado
    @materia_alumno = MateriaAlumno.new
    @materia_alumnos = MateriaAlumno
      .eager_load(materia_division: [:materia, :division], alumno: :perfil)
      .order(
        tabla_materias[:nombre].asc,
        tabla_divisiones[:nombre].asc,
        apellidos_coalesce.asc,
        nombres_coalesce.asc,
        tabla_usuarios[:email].asc
      )
      .distinct
      .load_async

    # Colecciones
    @turnos = Turno.order(:nombre)
    @cursos = Curso.order(:nombre)
    @orientaciones = Orientacion.order(:nombre)
    @ciclos = CicloLectivo.order(:año)
    @divisiones = Division.order(:nombre)

    # Usuarios por rol, sin duplicados
    @docentes = User.joins(:roles).where(roles: { nombre: "Docente" }).distinct.order(:email).load_async
    @alumnos = User.joins(:roles).where(roles: { nombre: "Alumno"  }).distinct.order(:email).load_async
  end
end
