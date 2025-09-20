require "application_system_test_case"

class AsistenciaMateriasTest < ApplicationSystemTestCase
  setup do
    @asistencia_materia = asistencia_materias(:one)
  end

  test "visiting the index" do
    visit asistencia_materias_url
    assert_selector "h1", text: "Asistencia materias"
  end

  test "should create asistencia materia" do
    visit asistencia_materias_url
    click_on "New asistencia materia"

    fill_in "Fecha", with: @asistencia_materia.fecha
    fill_in "Materia alumno", with: @asistencia_materia.materia_alumno_id
    fill_in "Modulo", with: @asistencia_materia.modulo
    fill_in "Observaciones", with: @asistencia_materia.observaciones
    fill_in "Parametro", with: @asistencia_materia.parametro_id
    click_on "Create Asistencia materia"

    assert_text "Asistencia materia was successfully created"
    click_on "Back"
  end

  test "should update Asistencia materia" do
    visit asistencia_materia_url(@asistencia_materia)
    click_on "Edit this asistencia materia", match: :first

    fill_in "Fecha", with: @asistencia_materia.fecha
    fill_in "Materia alumno", with: @asistencia_materia.materia_alumno_id
    fill_in "Modulo", with: @asistencia_materia.modulo
    fill_in "Observaciones", with: @asistencia_materia.observaciones
    fill_in "Parametro", with: @asistencia_materia.parametro_id
    click_on "Update Asistencia materia"

    assert_text "Asistencia materia was successfully updated"
    click_on "Back"
  end

  test "should destroy Asistencia materia" do
    visit asistencia_materia_url(@asistencia_materia)
    click_on "Destroy this asistencia materia", match: :first

    assert_text "Asistencia materia was successfully destroyed"
  end
end
