class Docente < ApplicationRecord
  belongs_to :perfil

  has_many :materia_docentes
  has_many :materias, through: :materia_docentes

  delegate :persona, to: :perfil, allow_nil: true
  delegate :nombres, :apellidos, :dni, :email, to: :persona, allow_nil: true
end
