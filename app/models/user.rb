class User < ApplicationRecord
  # Devise
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Relaciones con roles
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles,
                  after_add:    :_flush_roles_cache,
                  after_remove: :_flush_roles_cache

  # Relación con perfil (datos personales)
  has_one :perfil, dependent: :destroy
  accepts_nested_attributes_for :perfil

  # Delegación de atributos desde perfil
  delegate :nombres,
           :apellidos,
           :dni,
           :fecha_nacimiento,
           :direccion,
           :telefono,
           to: :perfil,
           allow_nil: true

  # Scopes por rol
  scope :with_role, ->(nombre) {
    joins(:roles)
      .where("LOWER(roles.nombre) = ?", nombre.to_s.downcase)
      .distinct
  }

  has_many :materia_docentes,    foreign_key: :docente_id, dependent: :destroy
  has_many :materia_divisiones,  through: :materia_docentes, source: :materia_division
  has_many :materias,            through: :materia_divisiones

  scope :docentes,        -> { with_role(:docente) }
  scope :alumnos,         -> { with_role(:alumno) }
  scope :preceptores,     -> { with_role(:preceptor) }
  scope :administradores, -> { with_role(:administrador) }

  # Métodos de roles
  def role_names
    @roles_array ||= roles.pluck(:nombre).map { |n| n.to_s.downcase }
  end

  def has_role?(role)
    role_names.include?(role.to_s.downcase)
  end

  def _flush_roles_cache(*) = (@roles_array = nil)

  # Métodos de nombre/display
  def full_name
    [nombres, apellidos].compact.join(' ')
  end

  def display_name
    full_name.presence || email
  end

  alias_method :label_for_select, :display_name
end
