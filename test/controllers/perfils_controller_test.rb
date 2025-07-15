require "test_helper"

class PerfilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perfil = perfils(:one)
  end

  test "should get index" do
    get perfils_url
    assert_response :success
  end

  test "should get new" do
    get new_perfil_url
    assert_response :success
  end

  test "should create perfil" do
    assert_difference("Perfil.count") do
      post perfils_url, params: { perfil: { personas_id: @perfil.personas_id } }
    end

    assert_redirected_to perfil_url(Perfil.last)
  end

  test "should show perfil" do
    get perfil_url(@perfil)
    assert_response :success
  end

  test "should get edit" do
    get edit_perfil_url(@perfil)
    assert_response :success
  end

  test "should update perfil" do
    patch perfil_url(@perfil), params: { perfil: { personas_id: @perfil.personas_id } }
    assert_redirected_to perfil_url(@perfil)
  end

  test "should destroy perfil" do
    assert_difference("Perfil.count", -1) do
      delete perfil_url(@perfil)
    end

    assert_redirected_to perfils_url
  end
end
