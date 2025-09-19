require "application_system_test_case"

class CicloLectivosTest < ApplicationSystemTestCase
  setup do
    @ciclo_lectivo = ciclo_lectivos(:one)
  end

  test "visiting the index" do
    visit ciclo_lectivos_url
    assert_selector "h1", text: "Ciclo lectivos"
  end

  test "should create ciclo lectivo" do
    visit ciclo_lectivos_url
    click_on "New ciclo lectivo"

    fill_in "Año", with: @ciclo_lectivo.año
    fill_in "Final", with: @ciclo_lectivo.final
    fill_in "Inicio", with: @ciclo_lectivo.inicio
    click_on "Create Ciclo lectivo"

    assert_text "Ciclo lectivo was successfully created"
    click_on "Back"
  end

  test "should update Ciclo lectivo" do
    visit ciclo_lectivo_url(@ciclo_lectivo)
    click_on "Edit this ciclo lectivo", match: :first

    fill_in "Año", with: @ciclo_lectivo.año
    fill_in "Final", with: @ciclo_lectivo.final
    fill_in "Inicio", with: @ciclo_lectivo.inicio
    click_on "Update Ciclo lectivo"

    assert_text "Ciclo lectivo was successfully updated"
    click_on "Back"
  end

  test "should destroy Ciclo lectivo" do
    visit ciclo_lectivo_url(@ciclo_lectivo)
    click_on "Destroy this ciclo lectivo", match: :first

    assert_text "Ciclo lectivo was successfully destroyed"
  end
end
