class PerfilsController < ApplicationController
  load_and_authorize_resource
  before_action :set_perfil, only: %i[ show edit update destroy ]
  before_action :load_selects, only: %i[new edit create update]

  # GET /perfils or /perfils.json
  def index
    @perfils = Perfil.all.includes(:user)
  end

  # GET /perfils/1 or /perfils/1.json
  def show
  end

  # GET /perfils/new
  def new
    @perfil = Perfil.new
  end

  # GET /perfils/1/edit
  def edit
  end

  # POST /perfils or /perfils.json
  def create
    @perfil = Perfil.new(perfil_params)

    respond_to do |format|
      if @perfil.save
        format.html { redirect_to @perfil, notice: "Perfil was successfully created." }
        format.json { render :show, status: :created, location: @perfil }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfils/1 or /perfils/1.json
  def update
    respond_to do |format|
      if @perfil.update(perfil_params)
        format.html { redirect_to @perfil, notice: "Perfil was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @perfil }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @perfil.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfils/1 or /perfils/1.json
  def destroy
    @perfil.destroy!

    respond_to do |format|
      format.html { redirect_to perfils_path, notice: "Perfil was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil
      @perfil = Perfil.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def perfil_params
      params.expect(perfil: [ :nombres, :apellidos, :dni, :fecha_nacimiento, :direccion, :telefono, :email, :user_id ])
    end

  def load_selects
    @users = User
              .left_joins(:perfil)
              .where(perfils: { id: nil })
              .includes(:perfil)
              .order(Arel.sql("COALESCE(perfils.apellidos, ''), COALESCE(perfils.nombres, ''), users.email"))
  end

end
