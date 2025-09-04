require "application_system_test_case"

class AsistenciaMateriaTest < ApplicationSystemTestCase
  setup do
    @asistencia_materium = asistencia_materia(:one)
  end

  test "visiting the index" do
    visit asistencia_materia_url
    assert_selector "h1", text: "Asistencia materia"
  end

  test "should create asistencia materium" do
    visit asistencia_materia_url
    click_on "New asistencia materium"

    fill_in "Fecha", with: @asistencia_materium.fecha
    fill_in "Materia alumno", with: @asistencia_materium.materia_alumno_id
    fill_in "Modulo", with: @asistencia_materium.modulo
    fill_in "Observaciones", with: @asistencia_materium.observaciones
    fill_in "Parametro", with: @asistencia_materium.parametro_id
    click_on "Create Asistencia materium"

    assert_text "Asistencia materium was successfully created"
    click_on "Back"
  end

  test "should update Asistencia materium" do
    visit asistencia_materium_url(@asistencia_materium)
    click_on "Edit this asistencia materium", match: :first

    fill_in "Fecha", with: @asistencia_materium.fecha
    fill_in "Materia alumno", with: @asistencia_materium.materia_alumno_id
    fill_in "Modulo", with: @asistencia_materium.modulo
    fill_in "Observaciones", with: @asistencia_materium.observaciones
    fill_in "Parametro", with: @asistencia_materium.parametro_id
    click_on "Update Asistencia materium"

    assert_text "Asistencia materium was successfully updated"
    click_on "Back"
  end

  test "should destroy Asistencia materium" do
    visit asistencia_materium_url(@asistencia_materium)
    click_on "Destroy this asistencia materium", match: :first

    assert_text "Asistencia materium was successfully destroyed"
  end
end
