class MateriaDocente < ApplicationRecord
  belongs_to :materia
  belongs_to :docente
  belongs_to :division
end
