module FormOptionsHelper

  def materia_division_label(md)
    "#{md.materia.nombre} - División #{md.division.nombre}"
  end
end