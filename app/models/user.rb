class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles,
                  after_add:    :_flush_roles_cache,
                  after_remove: :_flush_roles_cache

  has_one :perfil, dependent: :destroy

  has_many :materia_docentes, foreign_key: :docente_id
  
  delegate :nombres,
          :apellidos,
          :dni,
          :fecha_nacimiento,
          :direccion,
          :telefono,
          to: :perfil,
          allow_nil: true
          
  def role_names
    # Memoización de roles
    # Retorna un array de los roles (lowercase)
    @roles_array ||= roles.pluck(:name).map { |n| n.to_s.downcase }
  end

  def has_role?(role)
    role_names.include?(role.to_s.downcase)
  end

  def _flush_roles_cache(*) = (@roles_array = nil)
end
