class MateriaAlumno < ApplicationRecord
  belongs_to :materia_docente
  belongs_to :alumno
end
