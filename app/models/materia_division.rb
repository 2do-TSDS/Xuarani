class MateriaDivision < ApplicationRecord
  belongs_to :materia
  belongs_to :division

  has_many :materia_docentes, dependent: :destroy
  has_many :docentes, through: :materia_docentes, source: :docente
  has_many :alumnos, through: :materia_alumnos, source: :alumno
  has_many :modulos, dependent: :destroy

  validates :materia_id, presence: true
  validates :division_id, presence: true
  validates :materia_id, uniqueness: {
    scope: :division_id,
    message: "Esta materia ya está asignada a esta división"
  }
end
