class MateriasController < ApplicationController
  load_and_authorize_resource
  before_action :set_materia, only: %i[ show edit update destroy ]
  before_action :load_materia_selects, only: %i[new edit create update]

  # GET /materias or /materias.json
  def index
    @materias = Materia
      .includes(:turno, :curso, :orientacion, :ciclo_lectivo)
      .left_joins(:turno, :curso, :orientacion, :ciclo_lectivo)
      .order(Arel.sql(%q{
        `ciclo_lectivos`.`año` ASC,
        `orientacions`.`nombre` ASC,
        `cursos`.`nombre` ASC,
        `turnos`.`nombre` ASC,
        `materias`.`nombre` ASC
      }))

    # Agrupación jerárquica: Ciclo → Orientación → Curso
    @groups = @materias
      .group_by(&:ciclo_lectivo)
      .transform_values { |rows|
        rows.group_by(&:orientacion)
            .transform_values { |rows2|
              rows2.group_by(&:curso)
            }
      }
  end

  # GET /materias/1 or /materias/1.json
  def show
  end

  # GET /materias/new
  def new
    @materia = Materia.new(
      ciclo_lectivo_id: params[:ciclo_lectivo_id],
      orientacion_id:   params[:orientacion_id],
      curso_id:         params[:curso_id]
    )
    load_materia_selects
  end

  # GET /materias/1/edit
  def edit
  end

  # POST /materias or /materias.json
  def create
    @materia = Materia.new(materia_params)

    respond_to do |format|
      if @materia.save
        format.html { redirect_to @materia, notice: "Materia was successfully created." }
        format.json { render :show, status: :created, location: @materia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materias/1 or /materias/1.json
  def update
    respond_to do |format|
      if @materia.update(materia_params)
        format.html { redirect_to @materia, notice: "Materia was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @materia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materias/1 or /materias/1.json
  def destroy
    @materia.destroy!

    respond_to do |format|
      format.html { redirect_to materias_path, notice: "Materia was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia
      @materia = Materia.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def materia_params
      params.expect(materia: [ :nombre, :turno_id, :curso_id, :orientacion_id, :ciclo_lectivo_id ])
    end
  def load_materia_selects
    @turnos        = Turno.order(:nombre)
    @cursos        = Curso.order(:nombre)
    @orientaciones = Orientacion.order(:nombre)
    @ciclos        = CicloLectivo.order(Arel.sql('`año` ASC'))
  end

end
