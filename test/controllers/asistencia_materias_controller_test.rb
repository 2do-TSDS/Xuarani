require "test_helper"

class AsistenciaMateriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asistencia_materia = asistencia_materias(:one)
  end

  test "should get index" do
    get asistencia_materias_url
    assert_response :success
  end

  test "should get new" do
    get new_asistencia_materia_url
    assert_response :success
  end

  test "should create asistencia_materia" do
    assert_difference("AsistenciaMateria.count") do
      post asistencia_materias_url, params: { asistencia_materia: { fecha: @asistencia_materia.fecha, materia_alumno_id: @asistencia_materia.materia_alumno_id, modulo: @asistencia_materia.modulo, observaciones: @asistencia_materia.observaciones, parametro_id: @asistencia_materia.parametro_id } }
    end

    assert_redirected_to asistencia_materia_url(AsistenciaMateria.last)
  end

  test "should show asistencia_materia" do
    get asistencia_materia_url(@asistencia_materia)
    assert_response :success
  end

  test "should get edit" do
    get edit_asistencia_materia_url(@asistencia_materia)
    assert_response :success
  end

  test "should update asistencia_materia" do
    patch asistencia_materia_url(@asistencia_materia), params: { asistencia_materia: { fecha: @asistencia_materia.fecha, materia_alumno_id: @asistencia_materia.materia_alumno_id, modulo: @asistencia_materia.modulo, observaciones: @asistencia_materia.observaciones, parametro_id: @asistencia_materia.parametro_id } }
    assert_redirected_to asistencia_materia_url(@asistencia_materia)
  end

  test "should destroy asistencia_materia" do
    assert_difference("AsistenciaMateria.count", -1) do
      delete asistencia_materia_url(@asistencia_materia)
    end

    assert_redirected_to asistencia_materias_url
  end
end
