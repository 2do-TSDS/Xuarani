require "test_helper"

class MateriaTest < ActiveSupport::TestCase
  test "requiere nombre" do
    m = Materia.new
    assert_not m.valid?
    assert_presence_error m, :nombre
  end

  test "asociaciones clave existen" do
    assert_equal :has_many, Materia.reflect_on_association(:materia_divisiones).macro
    
  end
end
