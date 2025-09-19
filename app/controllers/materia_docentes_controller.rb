class MateriaDocentesController < ApplicationController
  before_action :set_materia_docente, only: %i[ show edit update destroy ]

  # GET /materia_docentes or /materia_docentes.json
  def index
    @materia_docentes = MateriaDocente.all
  end

  # GET /materia_docentes/1 or /materia_docentes/1.json
  def show
  end

  # GET /materia_docentes/new
  def new
    @materia_docente = MateriaDocente.new
  end

  # GET /materia_docentes/1/edit
  def edit
  end

  # POST /materia_docentes or /materia_docentes.json
  def create
    @materia_docente = MateriaDocente.new(materia_docente_params)

    respond_to do |format|
      if @materia_docente.save
        format.html { redirect_to @materia_docente, notice: "Materia docente was successfully created." }
        format.json { render :show, status: :created, location: @materia_docente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materia_docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materia_docentes/1 or /materia_docentes/1.json
  def update
    respond_to do |format|
      if @materia_docente.update(materia_docente_params)
        format.html { redirect_to @materia_docente, notice: "Materia docente was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @materia_docente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materia_docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materia_docentes/1 or /materia_docentes/1.json
  def destroy
    @materia_docente.destroy!

    respond_to do |format|
      format.html { redirect_to materia_docentes_path, notice: "Materia docente was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia_docente
      @materia_docente = MateriaDocente.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def materia_docente_params
      params.expect(materia_docente: [ :materia_division_id, :docente_id, :titular ])
    end
end
