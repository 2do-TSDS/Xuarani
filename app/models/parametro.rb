class Parametro < ApplicationRecord
    validates :abreviacion, presence: true, uniqueness: true
    validates :nombre, :valor, presence: true
end
