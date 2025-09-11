class Alumno < ApplicationRecord
  belongs_to :perfil

  has_many :materia_alumnos
  has_many :materia_docentes, through: :materia_alumnos

  delegate :persona, to: :perfil, allow_nil: true
  delegate :nombres, :apellidos, :dni, :email, to: :persona, allow_nil: true
end
