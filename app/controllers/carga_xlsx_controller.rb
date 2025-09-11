require 'roo'
require 'daru'

class CargaXlsxController < ApplicationController
  def index
    @division=nil
    @curso=nil
    @materias=nil
    @alumnos=nil
  end


  def procesar
    archivo_subido = params[:archivo_excel]

    if archivo_subido.present?
      ruta_temporal = archivo_subido.tempfile.path
      spreadsheet = Roo::Excelx.new(ruta_temporal)

      alumnos = []
      curso = ''
      division = ''
      materias = []
      spreadsheet.sheets.each do |sheet_name|
        sheet = spreadsheet.sheet(sheet_name)
        case sheet_name
          when 'Alumnos' then
            sheet.each_row_streaming() do |row|
              if row[0].nil?
                next
              end
              alumnos << row[0].cell_value
            end
          when 'Curso_Division' then
            sheet.each_row_streaming() do |row|
              curso = row[0].cell_value
              division = row[1].cell_value
            end
          when 'Materias' then
            sheet.each_row_streaming() do |row|
              if row[0].nil?
                next
              end
              materias << row[0].cell_value
            end
        end
      end
      @alumnos = alumnos
      @curso = curso
      @division = division
      @materias = materias
      flash.now[:notice] = "Archivo procesado correctamente."
    render :index
    end
  end
end
