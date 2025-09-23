class CursosController < ApplicationController
  include RedirectToOrganizacion
  before_action :set_curso, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  def index
    @cursos = Curso.all
  end

  def show; end

  def new
    @curso = Curso.new
  end

  def edit; end

  def create
    @curso = Curso.new(curso_params)
    if @curso.save
      if from_organizacion?
        redirect_back_to_organizacion("tab-cursos", "Curso creado correctamente.")
      else
        redirect_to @curso, notice: "Curso creado correctamente."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @curso.update(curso_params)
      if from_organizacion?
        redirect_back_to_organizacion("tab-cursos", "Curso actualizado.")
      else
        redirect_to @curso, notice: "Curso actualizado."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @curso.destroy
    if from_organizacion?
      redirect_back_to_organizacion("tab-cursos", "Curso eliminado.")
    else
      redirect_to cursos_url, notice: "Curso eliminado."
    end
  end

  private

  def set_curso
    @curso = Curso.find(params[:id])
  end

  def curso_params
    params.require(:curso).permit(:nombre)
  end
end
