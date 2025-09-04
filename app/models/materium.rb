class Materium < ApplicationRecord
  belongs_to :curso
  belongs_to :orientacion
  belongs_to :ciclo_lectivo
end
