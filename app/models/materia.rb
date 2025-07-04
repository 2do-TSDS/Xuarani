class Materia < ApplicationRecord
  validates :nombre, presence: true, length: { maximum: 32 }
end
