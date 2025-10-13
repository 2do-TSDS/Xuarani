class Parametro < ApplicationRecord
    validates :abreviacion, presence: true, uniqueness: true
    validates :nombre, presence: true
    validates :valor, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
