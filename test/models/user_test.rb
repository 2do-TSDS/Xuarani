require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Nota: estos tests NO usan fixtures. Creamos datos "a mano" para que sea simple.

  test "es válido con email y password" do
    u = User.new(email: "nuevo@example.com", password: "123456")
    assert u.valid?
  end

  test "no es válido sin email" do
    u = User.new(password: "123456")
    assert_not u.valid?
    assert_includes u.errors[:email], I18n.t("errors.messages.blank") 
  end

  test "email debe tener un @" do
    u = User.new(email: "malformado.com", password: "123456")
    assert_not u.valid?
    assert_includes u.errors[:email], I18n.t("errors.messages.invalid")
  end

  test "email es único (ignora mayúsculas/minúsculas)" do
    User.create!(email: "admin@demo.com", password: "123456")
    repetido = User.new(email: "ADMIN@demo.com", password: "123456")
    assert_not repetido.valid?
    assert_includes repetido.errors[:email], I18n.t("errors.messages.taken")
  end

  test "password tiene longitud mínima (Devise por defecto: 6)" do
    u = User.new(email: "mini@example.com", password: "123")
    assert_not u.valid?
    assert_includes u.errors[:password], I18n.t("errors.messages.too_short", count: 6)
  end

  test "role_names devuelve en minúscula y has_role? funciona" do
    #  usuario y un rol muy simples
    u = User.create!(email: "rol@example.com", password: "123456")
    r = Role.create!(nombre: "Administrador")

    # Le asignamos el rol
    u.roles << r

    # role_names debería traer ["administrador"]
    assert_includes u.role_names, "administrador"

    # has_role? debería reconocer el rol (símbolo o string)
    assert u.has_role?(:administrador)
    assert u.has_role?("administrador")
    assert_not u.has_role?(:docente)
  end

  test "display_name usa el email si no hay perfil" do
    u = User.create!(email: "sin.perfil@example.com", password: "123456")
    assert_equal "sin.perfil@example.com", u.display_name
  end
end

#Aqui lo que esta testeando es el modelo User, que tiene las siguientes validaciones y métodos:
# - Requiere email y password
# - Valida formato y unicidad del email
# - Valida longitud mínima del password
# - Tiene métodos para manejar roles (role_names y has_role?)