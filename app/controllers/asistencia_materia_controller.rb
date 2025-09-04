class AsistenciaMateriaController < ApplicationController
  before_action :set_asistencia_materium, only: %i[ show edit update destroy ]

  # GET /asistencia_materia or /asistencia_materia.json
  def index
    @asistencia_materia = AsistenciaMaterium.all
  end

  # GET /asistencia_materia/1 or /asistencia_materia/1.json
  def show
  end

  # GET /asistencia_materia/new
  def new
    @asistencia_materium = AsistenciaMaterium.new
  end

  # GET /asistencia_materia/1/edit
  def edit
  end

  # POST /asistencia_materia or /asistencia_materia.json
  def create
    @asistencia_materium = AsistenciaMaterium.new(asistencia_materium_params)

    respond_to do |format|
      if @asistencia_materium.save
        format.html { redirect_to @asistencia_materium, notice: "Asistencia materium was successfully created." }
        format.json { render :show, status: :created, location: @asistencia_materium }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asistencia_materium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asistencia_materia/1 or /asistencia_materia/1.json
  def update
    respond_to do |format|
      if @asistencia_materium.update(asistencia_materium_params)
        format.html { redirect_to @asistencia_materium, notice: "Asistencia materium was successfully updated." }
        format.json { render :show, status: :ok, location: @asistencia_materium }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asistencia_materium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencia_materia/1 or /asistencia_materia/1.json
  def destroy
    @asistencia_materium.destroy!

    respond_to do |format|
      format.html { redirect_to asistencia_materia_path, status: :see_other, notice: "Asistencia materium was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asistencia_materium
      @asistencia_materium = AsistenciaMaterium.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def asistencia_materium_params
      params.expect(asistencia_materium: [ :materia_alumno_id, :modulo, :parametro_id, :observaciones, :fecha ])
    end
end
