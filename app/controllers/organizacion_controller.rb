class OrganizacionController < ApplicationController
  before_action :authenticate_user!
  authorize_resource class: false

  def index
    authorize! :read, :organizacion

    @turnos         = Turno.order(:id)
    @cursos         = Curso.order(:id)
    @orientacions   = Orientacion.order(:id)
    @ciclo_lectivos = CicloLectivo.order(:id)
    @divisions      = Division.order(:id)

    @turno         = Turno.new
    @curso         = Curso.new
    @orientacion   = Orientacion.new
    @ciclo_lectivo = CicloLectivo.new
    @division      = Division.new
  end
end
