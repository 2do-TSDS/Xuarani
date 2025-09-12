# app/controllers/perfiles_controller.rb
class PerfilesController < ApplicationController
  def new
    @persona = Persona.new
    @perfil = @persona.build_perfil
  end

  def create
    @persona = Persona.new(persona_params)
    @perfil = @persona.build_perfil(perfil_params)

    if @persona.save && @perfil.save
      redirect_to @perfil, notice: 'Perfil creado exitosamente.'
    else
      render :new
    end
  end

  private

  def persona_params
    params.require(:persona).permit(:nombres, :apellidos, :dni, :email, 
                                   :fecha_nacimiento, :telefono, :direccion)
  end

  def perfil_params
    params.require(:perfil).permit(:tipo_perfil, :estado, :observaciones)
  end
end