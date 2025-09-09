require 'roo'
require 'daru'

class CargaXlsxController < ApplicationController
  def index
    @dataframe=nil
  end

  def procesar
    archivo_subido = params[:archivo_excel]

    if archivo_subido.present?
      ruta_temporal = archivo_subido.tempfile.path
      
      begin
        @dataframe = Daru::DataFrame.from_excel(ruta_temporal)
        flash.now[:notice] = "Archivo procesado correctamente."
      rescue => e
        @dataframe = nil
        flash.now[:alert] = "Error al leer el archivo: #{e.message}"
      end
    else
      flash.now[:alert] = "Por favor, selecciona un archivo."
    end
    
    render :index
  end
end
