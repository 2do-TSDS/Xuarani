class MateriaAlumno < ApplicationRecord
  belongs_to :materia
  belongs_to :alumno
end
