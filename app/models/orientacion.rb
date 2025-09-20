class Orientacion < ApplicationRecord
    validates :nombre, presence: true, uniqueness: true
end
