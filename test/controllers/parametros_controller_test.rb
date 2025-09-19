require "test_helper"

class ParametrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parametro = parametros(:one)
  end

  test "should get index" do
    get parametros_url
    assert_response :success
  end

  test "should get new" do
    get new_parametro_url
    assert_response :success
  end

  test "should create parametro" do
    assert_difference("Parametro.count") do
      post parametros_url, params: { parametro: { abreviacion: @parametro.abreviacion, nombre: @parametro.nombre, valor: @parametro.valor } }
    end

    assert_redirected_to parametro_url(Parametro.last)
  end

  test "should show parametro" do
    get parametro_url(@parametro)
    assert_response :success
  end

  test "should get edit" do
    get edit_parametro_url(@parametro)
    assert_response :success
  end

  test "should update parametro" do
    patch parametro_url(@parametro), params: { parametro: { abreviacion: @parametro.abreviacion, nombre: @parametro.nombre, valor: @parametro.valor } }
    assert_redirected_to parametro_url(@parametro)
  end

  test "should destroy parametro" do
    assert_difference("Parametro.count", -1) do
      delete parametro_url(@parametro)
    end

    assert_redirected_to parametros_url
  end
end
