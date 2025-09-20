class Materia < ApplicationRecord
  belongs_to :turno
  belongs_to :curso
  belongs_to :orientacion
  belongs_to :ciclo_lectivo

  validates :nombre, presence: true, uniqueness: true

  def nombre_con_curso
    "#{curso.nombre} — #{nombre}"
  end
  
end
