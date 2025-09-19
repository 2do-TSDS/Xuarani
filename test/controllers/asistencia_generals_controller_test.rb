require "test_helper"

class AsistenciaGeneralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asistencia_general = asistencia_generals(:one)
  end

  test "should get index" do
    get asistencia_generals_url
    assert_response :success
  end

  test "should get new" do
    get new_asistencia_general_url
    assert_response :success
  end

  test "should create asistencia_general" do
    assert_difference("AsistenciaGeneral.count") do
      post asistencia_generals_url, params: { asistencia_general: { alumno_id: @asistencia_general.alumno_id, fecha: @asistencia_general.fecha, observaciones: @asistencia_general.observaciones, parametro_id: @asistencia_general.parametro_id } }
    end

    assert_redirected_to asistencia_general_url(AsistenciaGeneral.last)
  end

  test "should show asistencia_general" do
    get asistencia_general_url(@asistencia_general)
    assert_response :success
  end

  test "should get edit" do
    get edit_asistencia_general_url(@asistencia_general)
    assert_response :success
  end

  test "should update asistencia_general" do
    patch asistencia_general_url(@asistencia_general), params: { asistencia_general: { alumno_id: @asistencia_general.alumno_id, fecha: @asistencia_general.fecha, observaciones: @asistencia_general.observaciones, parametro_id: @asistencia_general.parametro_id } }
    assert_redirected_to asistencia_general_url(@asistencia_general)
  end

  test "should destroy asistencia_general" do
    assert_difference("AsistenciaGeneral.count", -1) do
      delete asistencia_general_url(@asistencia_general)
    end

    assert_redirected_to asistencia_generals_url
  end
end
