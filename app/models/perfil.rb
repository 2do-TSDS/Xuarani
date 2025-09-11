class Perfil < ApplicationRecord
  belongs_to :persona

  has_one :alumno, dependent: :destroy
  has_one :docente, dependent: :destroy
end
