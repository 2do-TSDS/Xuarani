class AsistenciaMateriasController < ApplicationController
  load_and_authorize_resource
  # skip_load_and_authorize_resource only: [:planilla]
  before_action :set_asistencia_materia, only: %i[ show edit update destroy ]

  # GET /asistencia_materias or /asistencia_materias.json
  def index
    @asistencia_materias = AsistenciaMateria.all
  end

def planilla
  @materia_division = MateriaDivision.find(params[:materia_division_id])
  
  authorize! :read, @materia_division

  dia_de_hoy = Date.today.cwday
  modulo_config = Modulo.find_by(materia_division: @materia_division, dia: dia_de_hoy)
  
  @cantidad_modulos = modulo_config&.cantidad || 0
  @materia_alumnos = @materia_division.materia_alumnos.includes(
    { alumno: :perfil },
    :asistencias_de_hoy
  )

  @parametros = Parametro.all
  
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
