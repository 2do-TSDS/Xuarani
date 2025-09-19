class OrientacionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_orientacion, only: %i[ show edit update destroy ]

  # GET /orientacions or /orientacions.json
  def index
    @orientacions = Orientacion.all
  end

  # GET /orientacions/1 or /orientacions/1.json
  def show
  end

  # GET /orientacions/new
  def new
    @orientacion = Orientacion.new
  end

  # GET /orientacions/1/edit
  def edit
  end

  # POST /orientacions or /orientacions.json
  def create
    @orientacion = Orientacion.new(orientacion_params)

    respond_to do |format|
      if @orientacion.save
        format.html { redirect_to @orientacion, notice: "Orientacion was successfully created." }
        format.json { render :show, status: :created, location: @orientacion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orientacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orientacions/1 or /orientacions/1.json
  def update
    respond_to do |format|
      if @orientacion.update(orientacion_params)
        format.html { redirect_to @orientacion, notice: "Orientacion was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @orientacion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orientacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orientacions/1 or /orientacions/1.json
  def destroy
    @orientacion.destroy!

    respond_to do |format|
      format.html { redirect_to orientacions_path, notice: "Orientacion was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orientacion
      @orientacion = Orientacion.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def orientacion_params
      params.expect(orientacion: [ :nombre ])
    end
end
