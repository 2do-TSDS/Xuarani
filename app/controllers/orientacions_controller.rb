class OrientacionsController < ApplicationController
  include RedirectToOrganizacion
  before_action :set_orientacion, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
    @orientacions = Orientacion.all
  end

  def show; end

  def new
    @orientacion = Orientacion.new
  end

  def edit; end

  def create
    @orientacion = Orientacion.new(orientacion_params)
    if @orientacion.save
      if from_organizacion?
        redirect_back_to_organizacion("tab-orientaciones", "Orientación creada correctamente.")
      else
        redirect_to @orientacion, notice: "Orientación creada correctamente."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @orientacion.update(orientacion_params)
      if from_organizacion?
        redirect_back_to_organizacion("tab-orientaciones", "Orientación actualizada.")
      else
        redirect_to @orientacion, notice: "Orientación actualizada."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @orientacion.destroy
    if from_organizacion?
      redirect_back_to_organizacion("tab-orientaciones", "Orientación eliminada.")
    else
      redirect_to orientacions_url, notice: "Orientación eliminada."
    end
  end

  private

  def set_orientacion
    @orientacion = Orientacion.find(params[:id])
  end

  def orientacion_params
    params.require(:orientacion).permit(:nombre)
  end
end
