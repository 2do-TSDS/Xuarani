require "test_helper"
require "securerandom"

class AsistenciaGeneralTest < ActiveSupport::TestCase
  
  def build_parametro!
    # Parametro requiere abreviacion única, nombre y valor
    Parametro.create!(
      abreviacion: "P#{SecureRandom.hex(3)}",
      nombre:      "Param #{SecureRandom.hex(2)}",
      valor:       1.0
    )
  end

  def ensure_rol_alumno!
    # Crea (o reutiliza) el rol Alumno
    Role.where("LOWER(nombre) = ?", "alumno").first ||
      Role.create!(nombre: "Alumno")
  end

  def build_alumno_con_rol!
    ensure_rol_alumno!
    u = User.create!(email: "alumno_#{SecureRandom.hex(3)}@demo.com", password: "123456")
    u.roles << Role.where("LOWER(nombre) = ?", "alumno").first
    u
  end

  # ---- Tests ----

  test "válida con alumno (rol alumno), parámetro y fecha" do
    a = AsistenciaGeneral.new(
      alumno:    build_alumno_con_rol!,
      parametro: build_parametro!,
      fecha:     Date.today
    )
    assert a.valid?, a.errors.full_messages.to_sentence
  end

  test "requiere alumno" do
    a = AsistenciaGeneral.new(parametro: build_parametro!, fecha: Date.today)
    assert_not a.valid?
    assert a.errors.added?(:alumno, :blank)
  end

  test "requiere parámetro" do
    a = AsistenciaGeneral.new(alumno: build_alumno_con_rol!, fecha: Date.today)
    assert_not a.valid?
    assert a.errors.added?(:parametro, :blank)
  end

  test "requiere fecha" do
    a = AsistenciaGeneral.new(alumno: build_alumno_con_rol!, parametro: build_parametro!)
    assert_not a.valid?
    assert a.errors.added?(:fecha, :blank)
  end

  test "alumno debe tener rol alumno (valida mensaje custom)" do
    u = User.create!(email: "sinrol_#{SecureRandom.hex(3)}@demo.com", password: "123456") # sin rol
    a = AsistenciaGeneral.new(alumno: u, parametro: build_parametro!, fecha: Date.today)

    assert_not a.valid?
    assert_includes a.errors[:alumno],
      "Solo se podrá tomar asistencia a Usuarios con el rol de alumno"
  end

  test "no permite dos registros para el mismo alumno en la misma fecha" do
    alumno = build_alumno_con_rol!
    param  = build_parametro!
    fecha  = Date.today

    AsistenciaGeneral.create!(alumno: alumno, parametro: param, fecha: fecha)

    duplicado = AsistenciaGeneral.new(alumno: alumno, parametro: param, fecha: fecha)

    if AsistenciaGeneral.validators_on(:alumno_id).any? { |v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
      assert_not duplicado.valid?
      assert duplicado.errors.added?(:alumno_id, :taken)
    else
      # Si no hay validación en el modelo, el índice único de la BD debe reventar al guardar.
      assert_raises(ActiveRecord::RecordNotUnique) { duplicado.save!(validate: false) }
    end
  end

  test "asociaciones existen" do
    assoc_alumno    = AsistenciaGeneral.reflect_on_association(:alumno)
    assoc_parametro = AsistenciaGeneral.reflect_on_association(:parametro)

    assert assoc_alumno,    "Falta belongs_to :alumno"
    assert assoc_parametro, "Falta belongs_to :parametro"
    assert_equal :belongs_to, assoc_alumno.macro
    assert_equal :belongs_to, assoc_parametro.macro
  end
end

#Aqui lo que esta testeando es el modelo AsistenciaGeneral, que tiene las siguientes asociaciones y validaciones:
# - Pertenece a un alumno (que es un usuario con el rol de alumno)
# - Pertenece a un parámetro
# - Requiere que el alumno, el parámetro y la fecha estén presentes
# - Valida que el alumno tenga el rol de alumno
# - No permite dos registros para el mismo alumno en la misma fecha (esto puede ser valid
