class CicloLectivosController < ApplicationController
  before_action :set_ciclo_lectivo, only: %i[ show edit update destroy ]

  # GET /ciclo_lectivos
  def index
    @ciclo_lectivos = CicloLectivo.all
  end

  # GET /ciclo_lectivos/1
  def show
  end

  # GET /ciclo_lectivos/new
  def new
    @ciclo_lectivo = CicloLectivo.new
  end

  # GET /ciclo_lectivos/1/edit
  def edit
  end

  # POST /ciclo_lectivos
  def create
    @ciclo_lectivo = CicloLectivo.new(ciclo_lectivo_params)

    respond_to do |format|
      if @ciclo_lectivo.save
        format.html { redirect_to @ciclo_lectivo, notice: "Ciclo lectivo creado exitosamente." }
        format.json { render :show, status: :created, location: @ciclo_lectivo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ciclo_lectivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ciclo_lectivos/1
  def update
    respond_to do |format|
      if @ciclo_lectivo.update(ciclo_lectivo_params)
        format.html { redirect_to @ciclo_lectivo, notice: "Ciclo lectivo actualizado correctamente." }
        format.json { render :show, status: :ok, location: @ciclo_lectivo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ciclo_lectivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ciclo_lectivos/1
  def destroy
    @ciclo_lectivo.destroy!

    respond_to do |format|
      format.html { redirect_to ciclo_lectivos_path, status: :see_other, notice: "Ciclo lectivo eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  private

    def set_ciclo_lectivo
      @ciclo_lectivo = CicloLectivo.find(params[:id])
    end

    def ciclo_lectivo_params
      params.require(:ciclo_lectivo).permit(:anio, :inicio, :final)
    end
end
