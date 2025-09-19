class Division < ApplicationRecord
    validates :nombre, presence: true, uniqueness: true
end
