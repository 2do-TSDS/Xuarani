class MateriasPanelController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    @materia       = Materia.new
    @materias      = Materia.includes(:turno, :curso, :orientacion, :ciclo_lectivo).all

    @materia_division   = MateriaDivision.new
    @materia_divisions  = MateriaDivision.includes(:materia, :division).all
    @materia_divisiones = @materia_divisions  # alias para forms existentes

    @materia_docente  = MateriaDocente.new
    @materia_docentes = MateriaDocente.includes(:materia_division, :docente).all

    @materia_alumno  = MateriaAlumno.new
    @materia_alumnos = MateriaAlumno.includes(:materia_division, :alumno).all

    # Colecciones necesarias para los selects
    @turnos        = Turno.order(:nombre)
    @cursos        = Curso.order(:nombre)
    @orientaciones = Orientacion.order(:nombre)
    @ciclos        = CicloLectivo.order(:año)
    @divisiones    = Division.order(:nombre)

    # Colecciones específicas
    @docentes = User.joins(:roles).where(roles: { nombre: "Docente" }).order(:email)
    @alumnos  = User.joins(:roles).where(roles: { nombre: "Alumno" }).order(:email)

  end
end
