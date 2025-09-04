require "application_system_test_case"

class AsistenciaGeneralsTest < ApplicationSystemTestCase
  setup do
    @asistencia_general = asistencia_generals(:one)
  end

  test "visiting the index" do
    visit asistencia_generals_url
    assert_selector "h1", text: "Asistencia generals"
  end

  test "should create asistencia general" do
    visit asistencia_generals_url
    click_on "New asistencia general"

    fill_in "Alumno", with: @asistencia_general.alumno_id
    fill_in "Fecha", with: @asistencia_general.fecha
    fill_in "Observaciones", with: @asistencia_general.observaciones
    fill_in "Parametro", with: @asistencia_general.parametro_id
    click_on "Create Asistencia general"

    assert_text "Asistencia general was successfully created"
    click_on "Back"
  end

  test "should update Asistencia general" do
    visit asistencia_general_url(@asistencia_general)
    click_on "Edit this asistencia general", match: :first

    fill_in "Alumno", with: @asistencia_general.alumno_id
    fill_in "Fecha", with: @asistencia_general.fecha
    fill_in "Observaciones", with: @asistencia_general.observaciones
    fill_in "Parametro", with: @asistencia_general.parametro_id
    click_on "Update Asistencia general"

    assert_text "Asistencia general was successfully updated"
    click_on "Back"
  end

  test "should destroy Asistencia general" do
    visit asistencia_general_url(@asistencia_general)
    click_on "Destroy this asistencia general", match: :first

    assert_text "Asistencia general was successfully destroyed"
  end
end
