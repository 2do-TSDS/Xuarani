require "test_helper"
require "securerandom"

class AsistenciaMateriaTest < ActiveSupport::TestCase
  # ---------- Helpers (crean los datos necesarios) ----------

  def build_parametro!
    Parametro.create!(
      abreviacion: "P#{SecureRandom.hex(2)}",
      nombre:      "Param #{SecureRandom.hex(1)}",
      valor:       1.0
    )
  end

  # Garantiza que exista un rol de Alumno
  def ensure_rol_alumno!
    Role.where("LOWER(nombre) = ?", "alumno").first || Role.create!(nombre: "Alumno")
  end

  # Crea un usuario con rol Alumno
  def build_alumno_con_rol!
    ensure_rol_alumno!
    u = User.create!(email: "al_#{SecureRandom.hex(3)}@demo.com", password: "123456")
    u.roles << Role.where("LOWER(nombre) = ?", "alumno").first
    u
  end

  # Crea los catálogos necesarios (Ciclo, Curso, Turno, Orientación)
  def build_catalogos!
    ciclo = CicloLectivo.create!(año: 2025, inicio: Date.new(2025,3,1), final: Date.new(2025,12,15))
    curso = Curso.create!(nombre: "Curso #{SecureRandom.hex(2)}")
    turno = Turno.create!(nombre: "Mañana #{SecureRandom.hex(1)}")
    orient= Orientacion.create!(nombre: "Orient #{SecureRandom.hex(1)}")
    [ciclo, curso, turno, orient]
  end

  def build_materia_division!
    ciclo, curso, turno, orient = build_catalogos!
    materia = Materia.create!(
      nombre: "Mat #{SecureRandom.hex(2)}",
      turno: turno, curso: curso,
      orientacion: orient, ciclo_lectivo: ciclo
    )
    division = Division.create!(nombre: "1A-#{SecureRandom.hex(1)}")
    MateriaDivision.create!(materia: materia, division: division)
  end

  def build_materia_division_con_horario!(dia: Date.today.cwday, cantidad: 3)
    md = build_materia_division!
    Modulo.create!(materia_division: md, dia: dia, cantidad: cantidad)
    md
  end

  def build_materia_alumno_con_horario!(dia: Date.today.cwday)
    md = build_materia_division_con_horario!(dia: dia, cantidad: 3)
    alumno = build_alumno_con_rol!
    MateriaAlumno.create!(materia_division: md, alumno: alumno)
  end


  test "válida con materia_alumno, parámetro, fecha y modulo >= 1" do
    dia = Date.today.cwday
    am = AsistenciaMateria.new(
      materia_alumno: build_materia_alumno_con_horario!(dia: dia),
      parametro: build_parametro!,
      fecha: Date.today,
      modulo: 1
    )
    assert am.valid?, am.errors.full_messages.to_sentence
  end

  test "requiere materia_alumno" do
    am = AsistenciaMateria.new(parametro: build_parametro!, fecha: Date.today, modulo: 1)
    assert_not am.valid?
    assert am.errors.added?(:materia_alumno, :blank)
  end

  test "requiere parametro" do
    am = AsistenciaMateria.new(materia_alumno: build_materia_alumno_con_horario!, fecha: Date.today, modulo: 1)
    assert_not am.valid?
    assert am.errors.added?(:parametro, :blank)
  end

  test "requiere fecha" do
    am = AsistenciaMateria.new(materia_alumno: build_materia_alumno_con_horario!, parametro: build_parametro!, modulo: 1)
    assert_not am.valid?
    assert am.errors.added?(:fecha, :blank)
  end

  test "requiere modulo" do
    am = AsistenciaMateria.new(materia_alumno: build_materia_alumno_con_horario!, parametro: build_parametro!, fecha: Date.today, modulo: nil)
    assert_not am.valid?
    assert am.errors.added?(:modulo, :blank)
  end

  test "modulo debe ser >= 1 (valida o cae por check constraint)" do
    dia = Date.today.cwday
    am = AsistenciaMateria.new(
      materia_alumno: build_materia_alumno_con_horario!(dia: dia),
      parametro: build_parametro!,
      fecha: Date.today,
      modulo: 0
    )

    if AsistenciaMateria.validators_on(:modulo).any? { |v| v.is_a?(ActiveModel::Validations::NumericalityValidator) }
      assert_not am.valid?
      errores = am.errors.details[:modulo].map { |h| h[:error] }
      assert(
        errores.include?(:greater_than_or_equal_to) || errores.include?(:greater_than),
        "Se esperaba validación de rango en :modulo, errores: #{am.errors.full_messages}"
      )
    else
      assert_raises(ActiveRecord::StatementInvalid) { am.save!(validate: false) }
    end
  end

  test "no duplica (materia_alumno, fecha, modulo)" do
    dia = Date.today.cwday
    ma = build_materia_alumno_con_horario!(dia: dia)
    param = build_parametro!
    fecha = Date.today

    AsistenciaMateria.create!(materia_alumno: ma, parametro: param, fecha: fecha, modulo: 1)
    duplicada = AsistenciaMateria.new(materia_alumno: ma, parametro: param, fecha: fecha, modulo: 1)

    if AsistenciaMateria.validators_on(:materia_alumno_id).any? { |v| v.is_a?(ActiveRecord::Validations::UniquenessValidator) }
      assert_not duplicada.valid?
      assert duplicada.errors.added?(:materia_alumno_id, :taken)
    else
      assert_raises(ActiveRecord::RecordNotUnique) { duplicada.save!(validate: false) }
    end
  end

  test "no permite asistencia en día sin módulos definidos" do
    md = build_materia_division_con_horario!(dia: 2) # martes
    ma = MateriaAlumno.create!(materia_division: md, alumno: build_alumno_con_rol!)
    a = AsistenciaMateria.new(materia_alumno: ma, parametro: build_parametro!, fecha: Date.today, modulo: 1)

    assert_not a.valid?, "No debería permitir asistencia si no hay módulos para ese día"
    assert_includes a.errors.full_messages.join, "No hay módulos definidos para el día"
  end

  test "asociaciones existen" do
    assoc_ma = AsistenciaMateria.reflect_on_association(:materia_alumno)
    assoc_pa = AsistenciaMateria.reflect_on_association(:parametro)

    assert assoc_ma, "Falta belongs_to :materia_alumno"
    assert assoc_pa, "Falta belongs_to :parametro"
    assert_equal :belongs_to, assoc_ma.macro
    assert_equal :belongs_to, assoc_pa.macro
  end
end


# Aqui lo que esta testeandos es: :
#válida con materia_alumno, parámetro, fecha y modulo >= 1
#requiere materia_alumno
#requiere parametro
#requiere fecha
#requiere modulo
#modulo debe ser >= 1 (valida o cae por check constraint)
#no duplica (materia_alumno, fecha, modulo)
#asociaciones existen
#que no permite asistencia en día sin módulos definidos
