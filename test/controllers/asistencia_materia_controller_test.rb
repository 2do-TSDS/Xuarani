require "test_helper"

class AsistenciaMateriaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asistencia_materium = asistencia_materia(:one)
  end

  test "should get index" do
    get asistencia_materia_url
    assert_response :success
  end

  test "should get new" do
    get new_asistencia_materium_url
    assert_response :success
  end

  test "should create asistencia_materium" do
    assert_difference("AsistenciaMaterium.count") do
      post asistencia_materia_url, params: { asistencia_materium: { fecha: @asistencia_materium.fecha, materia_alumno_id: @asistencia_materium.materia_alumno_id, modulo: @asistencia_materium.modulo, observaciones: @asistencia_materium.observaciones, parametro_id: @asistencia_materium.parametro_id } }
    end

    assert_redirected_to asistencia_materium_url(AsistenciaMaterium.last)
  end

  test "should show asistencia_materium" do
    get asistencia_materium_url(@asistencia_materium)
    assert_response :success
  end

  test "should get edit" do
    get edit_asistencia_materium_url(@asistencia_materium)
    assert_response :success
  end

  test "should update asistencia_materium" do
    patch asistencia_materium_url(@asistencia_materium), params: { asistencia_materium: { fecha: @asistencia_materium.fecha, materia_alumno_id: @asistencia_materium.materia_alumno_id, modulo: @asistencia_materium.modulo, observaciones: @asistencia_materium.observaciones, parametro_id: @asistencia_materium.parametro_id } }
    assert_redirected_to asistencia_materium_url(@asistencia_materium)
  end

  test "should destroy asistencia_materium" do
    assert_difference("AsistenciaMaterium.count", -1) do
      delete asistencia_materium_url(@asistencia_materium)
    end

    assert_redirected_to asistencia_materia_url
  end
end
