class CicloLectivo < ApplicationRecord
    validates :año, presence: true
    validates :inicio, presence: true
    validates :final, presence: true
end
