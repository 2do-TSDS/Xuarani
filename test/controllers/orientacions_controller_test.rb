require "test_helper"

class OrientacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orientacion = orientacions(:one)
  end

  test "should get index" do
    get orientacions_url
    assert_response :success
  end

  test "should get new" do
    get new_orientacion_url
    assert_response :success
  end

  test "should create orientacion" do
    assert_difference("Orientacion.count") do
      post orientacions_url, params: { orientacion: { nombre: @orientacion.nombre } }
    end

    assert_redirected_to orientacion_url(Orientacion.last)
  end

  test "should show orientacion" do
    get orientacion_url(@orientacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_orientacion_url(@orientacion)
    assert_response :success
  end

  test "should update orientacion" do
    patch orientacion_url(@orientacion), params: { orientacion: { nombre: @orientacion.nombre } }
    assert_redirected_to orientacion_url(@orientacion)
  end

  test "should destroy orientacion" do
    assert_difference("Orientacion.count", -1) do
      delete orientacion_url(@orientacion)
    end

    assert_redirected_to orientacions_url
  end
end
