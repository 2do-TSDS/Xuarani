class DivisionsController < ApplicationController
  include RedirectToOrganizacion
  load_and_authorize_resource
  before_action :set_division, only: [:show, :edit, :update, :destroy]

  def index
    @divisions = Division.all
  end

  def show; end

  def new
    @division = Division.new
  end

  def edit; end

  def create
    @division = Division.new(division_params)
    if @division.save
      if from_organizacion?
        redirect_back_to_organizacion("tab-divisiones", "División creada correctamente.")
      else
        redirect_to @division, notice: "División creada correctamente."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @division.update(division_params)
      if from_organizacion?
        redirect_back_to_organizacion("tab-divisiones", "División actualizada.")
      else
        redirect_to @division, notice: "División actualizada."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @division.destroy
    if from_organizacion?
      redirect_back_to_organizacion("tab-divisiones", "División eliminada.")
    else
      redirect_to divisions_url, notice: "División eliminada."
    end
  end

  private

  def set_division
    @division = Division.find(params[:id])
  end

  def division_params
    params.require(:division).permit(:nombre)
  end
end
