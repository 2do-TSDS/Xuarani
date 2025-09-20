class AsistenciaGeneralsController < ApplicationController
  load_and_authorize_resource
  before_action :set_asistencia_general, only: %i[ show edit update destroy ]
  before_action :load_selects, only: %i[new edit create update]

  # GET /asistencia_generals or /asistencia_generals.json
  def index
    @asistencia_generals = AsistenciaGeneral
      .includes(alumno: :perfil, parametro: {})
      .order(fecha: :desc, 'perfils.apellidos': :asc, 'perfils.nombres': :asc)
      .references(:perfils)
  end

  # GET /asistencia_generals/1 or /asistencia_generals/1.json
  def show
  end

  # GET /asistencia_generals/new
  def new
    @asistencia_general = AsistenciaGeneral.new
  end

  # GET /asistencia_generals/1/edit
  def edit
  end

  # POST /asistencia_generals or /asistencia_generals.json
  def create
    @asistencia_general = AsistenciaGeneral.new(asistencia_general_params)

    respond_to do |format|
      if @asistencia_general.save
        format.html { redirect_to @asistencia_general, notice: "Asistencia cargada correctamente." }
        format.json { render :show, status: :created, location: @asistencia_general }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asistencia_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asistencia_generals/1 or /asistencia_generals/1.json
  def update
    respond_to do |format|
      if @asistencia_general.update(asistencia_general_params)
        format.html { redirect_to @asistencia_general, notice: "Asistencia actualizada correctamente.", status: :see_other }
        format.json { render :show, status: :ok, location: @asistencia_general }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asistencia_general.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asistencia_generals/1 or /asistencia_generals/1.json
  def destroy
    @asistencia_general.destroy!

    respond_to do |format|
      format.html { redirect_to asistencia_generals_path, notice: "Asistencia eliminada correctamente.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asistencia_general
      @asistencia_general = AsistenciaGeneral.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
  def asistencia_general_params
    params.require(:asistencia_general)
          .permit(:alumno_id, :parametro_id, :observaciones, :fecha)
  end

  def load_selects
    # Parámetros ordenados por nombre
    @parametros = Parametro.order(:nombre)

    # Alumnos: rol = alumno (case-insensitive), con perfil para nombres
    @alumnos = User.alumnos
                    .includes(:perfil)
                    .left_joins(:perfil)
                    .order(Arel.sql("COALESCE(perfils.apellidos, '') ASC, COALESCE(perfils.nombres, '') ASC, users.email ASC"))
  end
end
