class MateriaDivision < ApplicationRecord
  belongs_to :materia
  belongs_to :division

  has_many :materia_docentes, dependent: :destroy, inverse_of: :materia_division
  has_many :docentes, through: :materia_docentes, source: :docente

  # FALTABA esta relación base:
  has_many :materia_alumnos, dependent: :destroy
  has_many :alumnos, through: :materia_alumnos, source: :alumno

  has_many :modulos, dependent: :destroy

  # Scopes útiles
  scope :for_docente, ->(user) {
    joins(:materia_docentes).where(materia_docentes: { docente_id: user.id }).distinct
  }

  validates :materia_id, :division_id, presence: true
  validates :materia_id, uniqueness: {
    scope: :division_id,
    message: "Esta materia ya está asignada a esta división"
  }

  def display_name
    # safe navigation por si algo viene nil en seeds o fixtures
    [
      materia&.nombre,
      "#{materia&.curso&.nombre} #{division&.nombre}",
      materia&.orientacion&.nombre,
      materia&.ciclo_lectivo&.año
    ].compact.join(" - ")
  end
end
