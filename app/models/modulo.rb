class Modulo < ApplicationRecord
  belongs_to :materia_division

  validates :materia_division, presence: true
  validates :dia,       presence: true,
                        inclusion: { in: 1..7, message: "El dia proporcionado debe ser de 1..7 (lun..dom)" }
  validates :cantidad,  presence: true,
                        numericality: { only_integer: true, greater_than: 0 }


  validates :materia_division_id,
            uniqueness: {
              scope: :dia,
              message: "Ya existe un modulo definido para esta Materia en ese día."
            }
end