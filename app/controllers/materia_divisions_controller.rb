class MateriaDivisionsController < ApplicationController
  before_action :set_materia_division, only: %i[ show edit update destroy ]

  # GET /materia_divisions or /materia_divisions.json
  def index
    @materia_divisions = MateriaDivision.all
  end

  # GET /materia_divisions/1 or /materia_divisions/1.json
  def show
  end

  # GET /materia_divisions/new
  def new
    @materia_division = MateriaDivision.new
  end

  # GET /materia_divisions/1/edit
  def edit
  end

  # POST /materia_divisions or /materia_divisions.json
  def create
    @materia_division = MateriaDivision.new(materia_division_params)

    respond_to do |format|
      if @materia_division.save
        format.html { redirect_to @materia_division, notice: "Materia division was successfully created." }
        format.json { render :show, status: :created, location: @materia_division }
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
        format.html { redirect_to @materia_division, notice: "Materia division was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @materia_division }
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
      format.html { redirect_to materia_divisions_path, notice: "Materia division was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
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
end
