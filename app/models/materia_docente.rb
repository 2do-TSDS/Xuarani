class MateriaDocente < ApplicationRecord
  belongs_to :materia
  belongs_to :docente
  belongs_to :division

  has_many :materia_alumnos, dependent: :destroy
  has_many :alumnos, through: :materia_alumnos

  # Scopes con Includes para evitar complejidad algoritmica
  scope :con_info_completa, -> {
    includes(
      :division,
      { materia: :curso },
      { docente: :persona },
      { alumnos: :persona }
    )
  }

  scope :info_sin_alumnos, -> {
    includes(
      :division,
      { materia: :curso },
      { docente: :persona }
    )
  }
end
