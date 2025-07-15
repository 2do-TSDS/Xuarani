require "application_system_test_case"

class OrientacionsTest < ApplicationSystemTestCase
  setup do
    @orientacion = orientacions(:one)
  end

  test "visiting the index" do
    visit orientacions_url
    assert_selector "h1", text: "Orientacions"
  end

  test "should create orientacion" do
    visit orientacions_url
    click_on "New orientacion"

    fill_in "Nombre", with: @orientacion.nombre
    click_on "Create Orientacion"

    assert_text "Orientacion was successfully created"
    click_on "Back"
  end

  test "should update Orientacion" do
    visit orientacion_url(@orientacion)
    click_on "Edit this orientacion", match: :first

    fill_in "Nombre", with: @orientacion.nombre
    click_on "Update Orientacion"

    assert_text "Orientacion was successfully updated"
    click_on "Back"
  end

  test "should destroy Orientacion" do
    visit orientacion_url(@orientacion)
    click_on "Destroy this orientacion", match: :first

    assert_text "Orientacion was successfully destroyed"
  end
end
