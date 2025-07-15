class Materium < ApplicationRecord
  belongs_to :turno
  belongs_to :curso
  belongs_to :orientacion
  belongs_to :ciclo_lectivo
  belongs_to :docente
end
