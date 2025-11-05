class Role < ApplicationRecord
    has_many :users_roles, dependent: :destroy
    has_many :users, through: :users_roles

    validates :nombre, presence: true, uniqueness: true
end
