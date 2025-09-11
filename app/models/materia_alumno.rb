class MateriaAlumno < ApplicationRecord
  belongs_to :materia_docente
  belongs_to :alumno

  validates :materia_docente_id, uniqueness: { scope: :alumno_id }
end
