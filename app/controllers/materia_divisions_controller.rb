class MateriaDivisionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_materia_division, only: %i[ show edit update destroy ]
  before_action :materia_division_selects, only: %i[ new edit create update ]

  # GET /materia_divisions or /materia_divisions.json
  def index
    @cursos     = Curso.order(:nombre)
    @divisiones = Division.order(:nombre)

    @materia_divisions = MateriaDivision
      .includes(materia: :curso, division: {})
      .left_joins(materia: :curso, division: {})
      .order(Arel.sql("cursos.nombre ASC, divisions.nombre ASC, materias.nombre ASC"))

    # Lookup: curso -> (division -> [rows])
    @by_course_div = @materia_divisions
      .group_by { |md| md.materia.curso }
      .transform_values { |rows| rows.group_by(&:division) }
  end

  # GET /materia_divisions/1 or /materia_divisions/1.json
  def show
  end

  # GET /materia_divisions/new
  def new
    @materia_division = MateriaDivision.new(division_id: params[:division_id])
    @prefilter_curso_id = params[:curso_id]
  end

  # GET /materia_divisions/1/edit
  def edit
  end

  # POST /materia_divisions or /materia_divisions.json
  def create
    @materia_division = MateriaDivision.new(materia_division_params)

    respond_to do |format|
      if @materia_division.save
        format.html { redirect_to materia_divisions_path, notice: "Asignación creada exitosamente." }
        format.json { render :index, status: :created, location: @materia_division }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materia_division.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materia_divisions/1 or /materia_divisions/1.json
  def update
    respond_to do |format|
      if @materia_division.update(materia_division_params)
        format.html { redirect_to materia_divisions_path, notice: "Asignación actualizada exitosamente.", status: :see_other }
        format.json { render :index, status: :ok, location: @materia_division }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materia_division.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materia_divisions/1 or /materia_divisions/1.json
  def destroy
    @materia_division.destroy!

    respond_to do |format|
      format.html { redirect_to materia_divisions_path, notice: "Asignación eliminada exitosamente.", status: :see_other }
      format.json { head :no_content }
    end
  end
    # GET /materia_divisions/materias_disponibles.json
  # params: division_id, curso_id, current_materia_id
    def materias_disponibles
      division_id        = params[:division_id].presence
      curso_id           = params[:curso_id].presence
      current_materia_id = params[:current_materia_id].presence&.to_i

      scope = Materia.left_joins(:curso).includes(:curso)
      scope = scope.where(curso_id: curso_id) if curso_id

      if division_id
        assigned_ids = MateriaDivision.where(division_id: division_id).pluck(:materia_id)
        assigned_ids -= [current_materia_id] if current_materia_id
        scope = scope.where.not(id: assigned_ids) if assigned_ids.any?
      end

      scope = scope.order(Arel.sql("cursos.nombre ASC, materias.nombre ASC"))

      render json: scope.map { |m| { id: m.id, label: "#{m.curso.nombre} — #{m.nombre}" } }
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia_division
      @materia_division = MateriaDivision.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def materia_division_params
      params.expect(materia_division: [ :materia_id, :division_id ])
    end

  def materia_division_selects
    # 1) Determinacion de filtros
    selected_curso_id    = params[:curso_id].presence    || @materia_division&.materia&.curso_id
    selected_division_id = params[:division_id].presence || @materia_division&.division_id
    current_materia_id   = @materia_division&.materia_id

    # 2) Base scope con includes para evitar N+1 y ordenar
    scope = Materia.left_joins(:curso).includes(:curso)

    # 3) Filtrar por curso si corresponde
    scope = scope.where(curso_id: selected_curso_id) if selected_curso_id.present?

    # 4) Excluir materias ya asignadas en la división (salvo la actual al editar)
    if selected_division_id.present?
      assigned_ids = MateriaDivision.where(division_id: selected_division_id).pluck(:materia_id)
      assigned_ids -= [current_materia_id] if current_materia_id.present?
      scope = scope.where.not(id: assigned_ids) if assigned_ids.any?
    end

    @materias   = scope.order(Arel.sql("cursos.nombre ASC, materias.nombre ASC"))
    @divisiones = Division.order(:nombre)

    # Para titulo en el form
    @selected_curso    = Curso.find_by(id: selected_curso_id)       if selected_curso_id
    @selected_division = Division.find_by(id: selected_division_id) if selected_division_id
  end


end
