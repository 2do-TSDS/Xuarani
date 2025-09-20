class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :user_params
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = @users.order(:id)
  end

  def show; end

  def new; end
  def edit; end

  def create
    if @user.password.blank?
      tmp = SecureRandom.base58(12)
      @user.password = @user.password_confirmation = tmp
      @generated_password = tmp
    end

    if @user.save
      notice = "Usuario creado correctamente."
      notice += " Clave temporal: #{@generated_password}" if @generated_password.present?
      redirect_to @user, notice:
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if user_params[:password].blank?
      @user.assign_attributes(user_params.except(:password, :password_confirmation))
    else
      @user.assign_attributes(user_params)
    end

    if @user.save
      redirect_to @user, notice: "Usuario actualizado correctamente.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, notice: "Usuario eliminado.", status: :see_other
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation,
        role_ids: [] # many-to-many
      )
    end
end