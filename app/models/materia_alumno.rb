class MateriaAlumno < ApplicationRecord
  belongs_to :materia_division
  belongs_to :alumno, class_name: "User"

  has_one :materia, through: :materia_division
  has_one :division, through: :materia_division

  validates :materia_division, :alumno, presence: true
  validates :alumno_id, uniqueness: {
    scope: :materia_division_id,
    message: "El alumno ya está inscrito en esta materia"
  }
  validate :alumno_debe_tener_rol_alumno

  private

  def alumno_debe_tener_rol_alumno
    unless alumno&.has_role?("alumno")
      errors.add(:alumno, "El usuario debe tener el rol Alumno")
    end
  end

end
