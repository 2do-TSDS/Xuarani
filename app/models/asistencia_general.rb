class AsistenciaGeneral < ApplicationRecord
  belongs_to :alumno, class_name: "User"
  belongs_to :parametro

  validates :alumno, :parametro, :fecha, presence: true
  validate :alumno_debe_tener_rol_alumno

  private

  def alumno_debe_tener_rol_alumno
    if alumno && !alumno.has_role?(:alumno)
      errors.add(:alumno, "Solo se podrá tomar asistencia a Usuarios con el rol de alumno")
    end
  end
end
