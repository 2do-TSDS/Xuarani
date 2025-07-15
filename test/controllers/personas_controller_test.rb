require "test_helper"

class PersonasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @persona = personas(:one)
  end

  test "should get index" do
    get personas_url
    assert_response :success
  end

  test "should get new" do
    get new_persona_url
    assert_response :success
  end

  test "should create persona" do
    assert_difference("Persona.count") do
      post personas_url, params: { persona: { apellidos: @persona.apellidos, direccion: @persona.direccion, dni: @persona.dni, email: @persona.email, fecha_nacimiento: @persona.fecha_nacimiento, nombres: @persona.nombres, telefono: @persona.telefono } }
    end

    assert_redirected_to persona_url(Persona.last)
  end

  test "should show persona" do
    get persona_url(@persona)
    assert_response :success
  end

  test "should get edit" do
    get edit_persona_url(@persona)
    assert_response :success
  end

  test "should update persona" do
    patch persona_url(@persona), params: { persona: { apellidos: @persona.apellidos, direccion: @persona.direccion, dni: @persona.dni, email: @persona.email, fecha_nacimiento: @persona.fecha_nacimiento, nombres: @persona.nombres, telefono: @persona.telefono } }
    assert_redirected_to persona_url(@persona)
  end

  test "should destroy persona" do
    assert_difference("Persona.count", -1) do
      delete persona_url(@persona)
    end

    assert_redirected_to personas_url
  end
end
