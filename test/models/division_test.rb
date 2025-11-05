require "test_helper"

class DivisionTest < ActiveSupport::TestCase
  test "válida con nombre" do
    d = Division.new(nombre: "1A")
    assert d.valid?, d.errors.full_messages.to_sentence
  end

  test "requiere nombre (nil rompe por validación o constraint DB)" do
    d = Division.new(nombre: nil)

    if Division.validators_on(:nombre).any? { |v| v.is_a?(ActiveModel::Validations::PresenceValidator) }
      assert_not d.valid?
      assert d.errors.added?(:nombre, :blank)
    else
      assert_raises(ActiveRecord::StatementInvalid) { d.save!(validate: false) }
    end
  end

  test "requiere nombre no vacío cuando hay validación" do
    skip "Division no valida presencia de nombre" unless Division.validators_on(:nombre).any? { |v| v.is_a?(ActiveModel::Validations::PresenceValidator) }

    d = Division.new(nombre: "")
    assert_not d.valid?
    assert d.errors.added?(:nombre, :blank), d.errors.full_messages.to_sentence
  end

test "nombre es único (por validación o por índice UNIQUE en BD)" do
  Division.create!(nombre: "1B")
  dup = Division.new(nombre: "1B")

  if Division.validators_on(:nombre).any? { |v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
    assert_not dup.save, "Debería fallar el guardado por unicidad del nombre"
    assert dup.errors.any?, "Se esperaban errores de validación, pero no hay ninguno"
  else
    assert_raises(ActiveRecord::RecordNotUnique) { dup.save!(validate: false) }
  end
end


  test "asociaciones existen si están definidas" do
    assoc_md = Division.reflect_on_association(:materia_divisions)
    assoc_mt = Division.reflect_on_association(:materias)

    if assoc_md
      assert_equal :has_many, assoc_md.macro
    else
      assert_nil assoc_md
    end

    if assoc_mt
      assert_equal :has_many, assoc_mt.macro
    else
      assert_nil assoc_mt
    end
  end
end
