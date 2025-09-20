class ModulosController < ApplicationController
  load_and_authorize_resource
  before_action :set_modulo, only: %i[ show edit update destroy ]

  # GET /modulos or /modulos.json
  def index
    @modulos = Modulo.all
  end

  # GET /modulos/1 or /modulos/1.json
  def show
  end

  # GET /modulos/new
  def new
    @modulo = Modulo.new
  end

  # GET /modulos/1/edit
  def edit
  end

  # POST /modulos or /modulos.json
  def create
    @modulo = Modulo.new(modulo_params)

    respond_to do |format|
      if @modulo.save
        format.html { redirect_to @modulo, notice: "Modulo was successfully created." }
        format.json { render :show, status: :created, location: @modulo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @modulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modulos/1 or /modulos/1.json
  def update
    respond_to do |format|
      if @modulo.update(modulo_params)
        format.html { redirect_to @modulo, notice: "Modulo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @modulo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @modulo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modulos/1 or /modulos/1.json
  def destroy
    @modulo.destroy!

    respond_to do |format|
      format.html { redirect_to modulos_path, notice: "Modulo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modulo
      @modulo = Modulo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def modulo_params
      params.expect(modulo: [ :materia_division_id, :dia, :cantidad ])
    end
end
