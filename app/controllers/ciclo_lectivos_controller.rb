class CicloLectivosController < ApplicationController
  include RedirectToOrganizacion
  load_and_authorize_resource
  before_action :set_ciclo_lectivo, only: [:show, :edit, :update, :destroy]

  def index
    @ciclo_lectivos = CicloLectivo.all
  end

  def show; end

  def new
    @ciclo_lectivo = CicloLectivo.new
  end

  def edit; end

  def create
    @ciclo_lectivo = CicloLectivo.new(ciclo_lectivo_params)
    if @ciclo_lectivo.save
      if from_organizacion?
        redirect_back_to_organizacion("tab-ciclos", "Ciclo lectivo creado correctamente.")
      else
        redirect_to @ciclo_lectivo, notice: "Ciclo lectivo creado correctamente."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ciclo_lectivo.update(ciclo_lectivo_params)
      if from_organizacion?
        redirect_back_to_organizacion("tab-ciclos", "Ciclo lectivo actualizado.")
      else
        redirect_to @ciclo_lectivo, notice: "Ciclo lectivo actualizado."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ciclo_lectivo.destroy
    if from_organizacion?
      redirect_back_to_organizacion("tab-ciclos", "Ciclo lectivo eliminado.")
    else
      redirect_to ciclo_lectivos_url, notice: "Ciclo lectivo eliminado."
    end
  end

  private

  def set_ciclo_lectivo
    @ciclo_lectivo = CicloLectivo.find(params[:id])
  end

  def ciclo_lectivo_params
    params.require(:ciclo_lectivo).permit(:año, :inicio, :final)
  end
end
