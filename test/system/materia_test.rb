require "application_system_test_case"

class MateriaTest < ApplicationSystemTestCase
  setup do
    @materium = materia(:one)
  end

  test "visiting the index" do
    visit materia_url
    assert_selector "h1", text: "Materia"
  end

  test "should create materium" do
    visit materia_url
    click_on "New materium"

    fill_in "Ciclo lectivo", with: @materium.ciclo_lectivo_id
    fill_in "Curso", with: @materium.curso_id
    fill_in "Docente", with: @materium.docente_id
    fill_in "Nombre", with: @materium.nombre
    fill_in "Orientacion", with: @materium.orientacion_id
    fill_in "Turno", with: @materium.turno_id
    click_on "Create Materium"

    assert_text "Materium was successfully created"
    click_on "Back"
  end

  test "should update Materium" do
    visit materium_url(@materium)
    click_on "Edit this materium", match: :first

    fill_in "Ciclo lectivo", with: @materium.ciclo_lectivo_id
    fill_in "Curso", with: @materium.curso_id
    fill_in "Docente", with: @materium.docente_id
    fill_in "Nombre", with: @materium.nombre
    fill_in "Orientacion", with: @materium.orientacion_id
    fill_in "Turno", with: @materium.turno_id
    click_on "Update Materium"

    assert_text "Materium was successfully updated"
    click_on "Back"
  end

  test "should destroy Materium" do
    visit materium_url(@materium)
    click_on "Destroy this materium", match: :first

    assert_text "Materium was successfully destroyed"
  end
end
