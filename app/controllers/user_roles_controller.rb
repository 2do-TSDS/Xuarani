class UserRolesController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_role, only: %i[ show edit update destroy ]
  before_action :load_selects, only: %i[new edit create update]

  # GET /user_roles or /user_roles.json
  def index
    @users = User
               .joins(:roles)
               .includes(:roles, :perfil)
               .left_joins(:perfil)
               .distinct
               .order(Arel.sql("COALESCE(perfils.apellidos, '') ASC,
                                COALESCE(perfils.nombres,  '') ASC,
                                users.email ASC"))
  end
  # GET /user_roles/1 or /user_roles/1.json
  def show
  end

  # GET /user_roles/new
  def new
    @user_role = UserRole.new
  end

  # GET /user_roles/1/edit
  def edit
  end

  # POST /user_roles or /user_roles.json
  def create
    @user_role = UserRole.new(user_role_params)

    respond_to do |format|
      if @user_role.save
        format.html { redirect_to @user_role, notice: "User role was successfully created." }
        format.json { render :show, status: :created, location: @user_role }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_roles/1 or /user_roles/1.json
  def update
    respond_to do |format|
      if @user_role.update(user_role_params)
        format.html { redirect_to @user_role, notice: "User role was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_role }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_roles/1 or /user_roles/1.json
  def destroy
    @user_role.destroy!

    respond_to do |format|
      format.html { redirect_to user_roles_path, notice: "User role was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_role
      @user_role = UserRole.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_role_params
      params.expect(user_role: [ :user_id, :role_id ])
    end
    
  def load_selects
    @users = User
              .includes(:perfil)
              .left_joins(:perfil)
              .order(Arel.sql("COALESCE(perfils.apellidos, ''), COALESCE(perfils.nombres, ''), users.email"))

    @roles = Role.order(:nombre)
  end
end
