require "test_helper"

class CicloLectivosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ciclo_lectivo = ciclo_lectivos(:one)
  end

  test "should get index" do
    get ciclo_lectivos_url
    assert_response :success
  end

  test "should get new" do
    get new_ciclo_lectivo_url
    assert_response :success
  end

  test "should create ciclo_lectivo" do
    assert_difference("CicloLectivo.count") do
      post ciclo_lectivos_url, params: { ciclo_lectivo: { año: @ciclo_lectivo.año, final: @ciclo_lectivo.final, inicio: @ciclo_lectivo.inicio } }
    end

    assert_redirected_to ciclo_lectivo_url(CicloLectivo.last)
  end

  test "should show ciclo_lectivo" do
    get ciclo_lectivo_url(@ciclo_lectivo)
    assert_response :success
  end

  test "should get edit" do
    get edit_ciclo_lectivo_url(@ciclo_lectivo)
    assert_response :success
  end

  test "should update ciclo_lectivo" do
    patch ciclo_lectivo_url(@ciclo_lectivo), params: { ciclo_lectivo: { año: @ciclo_lectivo.año, final: @ciclo_lectivo.final, inicio: @ciclo_lectivo.inicio } }
    assert_redirected_to ciclo_lectivo_url(@ciclo_lectivo)
  end

  test "should destroy ciclo_lectivo" do
    assert_difference("CicloLectivo.count", -1) do
      delete ciclo_lectivo_url(@ciclo_lectivo)
    end

    assert_redirected_to ciclo_lectivos_url
  end
end
