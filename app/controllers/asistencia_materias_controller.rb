class AsistenciaMateriasController < ApplicationController
  load_and_authorize_resource
  before_action :set_asistencia_materia, only: %i[ show edit update destroy ]

  # GET /asistencia_materias or /asistencia_materias.json
  def index
    @asistencia_materias = AsistenciaMateria.all
  end

  # GET /asistencia_materias/1 or /asistencia_materias/1.json
  def show
  end

  # GET /asistencia_materias/new
  def new
    @asistencia_materia = AsistenciaMateria.new
  end

  # GET /asistencia_materias/1/edit
  def edit
  end

  # POST /asistencia_materias or /asistencia_materias.json
  def create
    @asistencia_materia = AsistenciaMateria.new(asistencia_materia_params)

    respond_to do |format|
      if @asistencia_materia.save
        format.html { redirect_to @asistencia_materia, notice: "Asistencia materia was successfully created." }
        format.json { render :show, status: :created, location: @asistencia_materia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asistencia_materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asistencia_materias/1 or /asistencia_materias/1.json
  def update
    respond_to do |format|
      if @asistencia_materia.update(asistencia_materia_params)
        format.html { redirect_to @asistencia_materia, notice: "Asistencia materia was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @asistencia_materia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asistencia_materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencia_materias/1 or /asistencia_materias/1.json
  def destroy
    @asistencia_materia.destroy!

    respond_to do |format|
      format.html { redirect_to asistencia_materias_path, notice: "Asistencia materia was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asistencia_materia
      @asistencia_materia = AsistenciaMateria.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def asistencia_materia_params
      params.expect(asistencia_materia: [ :materia_alumno_id, :parametro_id, :observaciones, :fecha, :modulo ])
    end
end
