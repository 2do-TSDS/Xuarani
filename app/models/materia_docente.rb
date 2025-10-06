class MateriaDocente < ApplicationRecord
  belongs_to :materia_division, inverse_of: :materia_docentes
  belongs_to :docente, class_name: "User", inverse_of: :materia_docentes

  # NO: has_many :materia_divisions
  # En su lugar, si querés acceder directo:
  has_one  :materia,  through: :materia_division
  has_one  :division, through: :materia_division

  delegate :materia, :division, to: :materia_division

  scope :titulares, -> { where(titular: true) }
  scope :suplentes, -> { where(titular: false) }
  scope :for_docente, ->(user) { where(docente_id: user.id) }

  validates :materia_division, :docente, presence: true
  validates :titular, inclusion: { in: [true, false] }

  # Un docente no puede repetirse en la misma MD
  validates :docente_id, uniqueness: {
    scope: :materia_division_id,
    message: "El docente se encuentra asignado a esta Materia en esta División"
  }

  # Solo puede haber un titular por MD
  validates :materia_division_id, uniqueness: {
    conditions: -> { where(titular: true) },
    message: "Ya existe un docente titular asignado a esta Materia en esta División"
  }

  validate :docente_debe_tener_rol_docente

  private

  def docente_debe_tener_rol_docente
    unless docente&.has_role?("docente")
      errors.add(:docente, "El usuario debe tener el rol Docente")
    end
  end
end
