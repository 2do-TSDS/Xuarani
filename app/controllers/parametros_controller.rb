class ParametrosController < ApplicationController
  before_action :set_parametro, only: %i[ show edit update destroy ]

  # GET /parametros or /parametros.json
  def index
    @parametros = Parametro.all
  end

  # GET /parametros/1 or /parametros/1.json
  def show
  end

  # GET /parametros/new
  def new
    @parametro = Parametro.new
  end

  # GET /parametros/1/edit
  def edit
  end

  # POST /parametros or /parametros.json
  def create
    @parametro = Parametro.new(parametro_params)

    respond_to do |format|
      if @parametro.save
        format.html { redirect_to @parametro, notice: "Parametro was successfully created." }
        format.json { render :show, status: :created, location: @parametro }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametros/1 or /parametros/1.json
  def update
    respond_to do |format|
      if @parametro.update(parametro_params)
        format.html { redirect_to @parametro, notice: "Parametro was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @parametro }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parametro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametros/1 or /parametros/1.json
  def destroy
    @parametro.destroy!

    respond_to do |format|
      format.html { redirect_to parametros_path, notice: "Parametro was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parametro
      @parametro = Parametro.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def parametro_params
      params.expect(parametro: [ :abreviacion, :nombre, :valor ])
    end
end
