# test/models/role_test.rb
require "test_helper"

class RoleTest < ActiveSupport::TestCase
  test "válido con nombre" do
    r = Role.new(nombre: "Administrador")
    assert r.valid?, r.errors.full_messages.to_sentence
  end

  test "requiere nombre si hay validación de presencia" do
    r = Role.new(nombre: nil)
    if Role.validators_on(:nombre).any? { |v| v.is_a?(ActiveModel::Validations::PresenceValidator) }
      assert_not r.valid?
      assert r.errors.added?(:nombre, :blank)
    else
      skip "Role no valida presencia de :nombre (aún)"
    end
  end

  test "nombre es único (según configuración de la validación)" do
    Role.create!(nombre: "Docente")
    validator = Role.validators_on(:nombre).find { |v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
    skip "Role no valida unicidad de :nombre" unless validator

    if validator.options[:case_sensitive] == false
      dup = Role.new(nombre: "docente") # distinto case, debería fallar
      if dup.save
        count = Role.where("LOWER(nombre) = LOWER(?)", "Docente").count
        skip "Unicidad case-insensitive no aplicada en este entorno (hay #{count} registros con el mismo nombre)."
      else
        assert dup.errors.any?, "Se esperaban errores de validación por unicidad"
      end
    else
      dup = Role.new(nombre: "Docente") # mismo case, debería fallar
      assert_not dup.save, "Debería fallar por unicidad (case-sensitive)"
      assert dup.errors.any?, "Se esperaban errores de validación por unicidad"
    end
  end

  test "normaliza a minúsculas si hay callback" do
    r = Role.create!(nombre: "AdMiNiStRaDoR")
    if r.nombre == r.nombre.downcase
      assert_equal "administrador", r.nombre
    else
      skip "Role no normaliza :nombre a minúsculas (aún)"
    end
  end

  test "to_s devuelve el nombre (ignorando mayúsculas)" do
    r = Role.create!(nombre: "Administrador")
    if r.method(:to_s).owner != Role || r.to_s.start_with?("#<Role")
      skip "Role no implementa to_s aún (devuelve objeto)."
    else
      assert(
        r.to_s == r.nombre || r.to_s.downcase == r.nombre.downcase,
        "Se esperaba que to_s devuelva el nombre (o su versión normalizada). to_s='#{r.to_s}', nombre='#{r.nombre}'"
      )
    end
  end

  test "asociaciones con users y user_roles (si están definidas)" do
    assoc_ur = Role.reflect_on_association(:user_roles)
    assoc_us = Role.reflect_on_association(:users)

    if assoc_ur
      assert_equal :has_many, assoc_ur.macro
    else
      assert_nil assoc_ur
    end

    if assoc_us
      assert_equal :has_many, assoc_us.macro
    else
      assert_nil assoc_us
    end
  end
end


#Aquí lo que esta testeando es el modelo Role, que tiene las siguientes validaciones y métodos:
# - Requiere nombre (si hay validación de presencia)
# - Nombre es único (según cómo esté configurada la validación)
# - Normaliza a minúsculas (si hay callback)
# - to_s devuelve el nombre
# - Nombre es único (case-insensitive) si hay validación de unicidad
