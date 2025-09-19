class Curso < ApplicationRecord
    validates :nombre, presence: true, uniqueness: true
end
