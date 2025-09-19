class CicloLectivosController < ApplicationController
  before_action :set_ciclo_lectivo, only: %i[ show edit update destroy ]

  # GET /ciclo_lectivos or /ciclo_lectivos.json
  def index
    @ciclo_lectivos = CicloLectivo.all
  end

  # GET /ciclo_lectivos/1 or /ciclo_lectivos/1.json
  def show
  end

  # GET /ciclo_lectivos/new
  def new
    @ciclo_lectivo = CicloLectivo.new
  end

  # GET /ciclo_lectivos/1/edit
  def edit
  end

  # POST /ciclo_lectivos or /ciclo_lectivos.json
  def create
    @ciclo_lectivo = CicloLectivo.new(ciclo_lectivo_params)

    respond_to do |format|
      if @ciclo_lectivo.save
        format.html { redirect_to @ciclo_lectivo, notice: "Ciclo lectivo was successfully created." }
        format.json { render :show, status: :created, location: @ciclo_lectivo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ciclo_lectivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ciclo_lectivos/1 or /ciclo_lectivos/1.json
  def update
    respond_to do |format|
      if @ciclo_lectivo.update(ciclo_lectivo_params)
        format.html { redirect_to @ciclo_lectivo, notice: "Ciclo lectivo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ciclo_lectivo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ciclo_lectivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ciclo_lectivos/1 or /ciclo_lectivos/1.json
  def destroy
    @ciclo_lectivo.destroy!

    respond_to do |format|
      format.html { redirect_to ciclo_lectivos_path, notice: "Ciclo lectivo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ciclo_lectivo
      @ciclo_lectivo = CicloLectivo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ciclo_lectivo_params
      params.expect(ciclo_lectivo: [ :año, :inicio, :final ])
    end
end
