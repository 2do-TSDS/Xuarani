class Materium < ApplicationRecord
  belongs_to :curso
  belongs_to :orientacion
  belongs_to :ciclo_lectivo

  has_many :materia_docentes, dependent: :destroy
  has_many :docentes, through: :materia_docentes
end
