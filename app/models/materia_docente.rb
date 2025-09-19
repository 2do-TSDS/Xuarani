class MateriaDocente < ApplicationRecord
  belongs_to :materia_division
  belongs_to :docente, class_name: "User"

  has_many :materia_divisions
  has_many :materias, through: :materia_divisions

  scope :titulares, -> { where(titular: true) }
  scope :suplentes, -> { where(titular: false) }

  validates :materia_division, :docente, presence: true
  validates :titular, inclusion: { in: [true, false] }
  validates :docente_id, uniqueness: {
    scope: :materia_division_id,
    message: "El docente se encuentra asignado a esta Materia en esta Division"
  }
  validates :materia_division_id, uniqueness: {
    conditions: -> { where(titular: true) },
    message: "Ya existe un docente titular asignado a esta Materia en esta Division"
  }
  validate :docente_debe_tener_rol_docente

  private
  def docente_debe_tener_rol_docente
    unless docente&.has_role?("docente")
      errors.add(:docente, "El usuario debe tener el rol Docente")
    end
  end

end
