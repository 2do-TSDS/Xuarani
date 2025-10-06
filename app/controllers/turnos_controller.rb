class TurnosController < ApplicationController
  include RedirectToOrganizacion
  before_action :set_turno, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
    @turnos = Turno.all
  end

  def show; end

  def new
    @turno = Turno.new
  end

  def edit; end

  def create
    @turno = Turno.new(turno_params)
    if @turno.save
      if from_organizacion?
        redirect_back_to_organizacion("tab-turnos", "Turno creado correctamente.")
      else
        redirect_to @turno, notice: "Turno creado correctamente."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @turno.update(turno_params)
      if from_organizacion?
        redirect_back_to_organizacion("tab-turnos", "Turno actualizado.")
      else
        redirect_to @turno, notice: "Turno actualizado."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @turno.destroy
    if from_organizacion?
      redirect_back_to_organizacion("tab-turnos", "Turno eliminado.")
    else
      redirect_to turnos_url, notice: "Turno eliminado."
    end
  end

  private

  def set_turno
    @turno = Turno.find(params[:id])
  end

  def turno_params
    params.require(:turno).permit(:nombre)
  end
end
