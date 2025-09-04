class AsistenciaMaterium < ApplicationRecord
  belongs_to :materia_alumno
  belongs_to :parametro
end
