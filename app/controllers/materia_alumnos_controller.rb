class MateriaAlumnosController < ApplicationController
  before_action :set_materia_alumno, only: %i[ show edit update destroy ]

  # GET /materia_alumnos or /materia_alumnos.json
  def index
    @materia_alumnos = MateriaAlumno.all
  end

  # GET /materia_alumnos/1 or /materia_alumnos/1.json
  def show
  end

  # GET /materia_alumnos/new
  def new
    @materia_alumno = MateriaAlumno.new
  end

  # GET /materia_alumnos/1/edit
  def edit
  end

  # POST /materia_alumnos or /materia_alumnos.json
  def create
    @materia_alumno = MateriaAlumno.new(materia_alumno_params)

    respond_to do |format|
      if @materia_alumno.save
        format.html { redirect_to @materia_alumno, notice: "Materia alumno was successfully created." }
        format.json { render :show, status: :created, location: @materia_alumno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materia_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materia_alumnos/1 or /materia_alumnos/1.json
  def update
    respond_to do |format|
      if @materia_alumno.update(materia_alumno_params)
        format.html { redirect_to @materia_alumno, notice: "Materia alumno was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @materia_alumno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materia_alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materia_alumnos/1 or /materia_alumnos/1.json
  def destroy
    @materia_alumno.destroy!

    respond_to do |format|
      format.html { redirect_to materia_alumnos_path, notice: "Materia alumno was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia_alumno
      @materia_alumno = MateriaAlumno.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def materia_alumno_params
      params.expect(materia_alumno: [ :materia_division_id, :alumno_id ])
    end
end
