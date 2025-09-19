require "application_system_test_case"

class MateriaDocentesTest < ApplicationSystemTestCase
  setup do
    @materia_docente = materia_docentes(:one)
  end

  test "visiting the index" do
    visit materia_docentes_url
    assert_selector "h1", text: "Materia docentes"
  end

  test "should create materia docente" do
    visit materia_docentes_url
    click_on "New materia docente"

    fill_in "Docente", with: @materia_docente.docente_id
    fill_in "Materia division", with: @materia_docente.materia_division_id
    check "Titular" if @materia_docente.titular
    click_on "Create Materia docente"

    assert_text "Materia docente was successfully created"
    click_on "Back"
  end

  test "should update Materia docente" do
    visit materia_docente_url(@materia_docente)
    click_on "Edit this materia docente", match: :first

    fill_in "Docente", with: @materia_docente.docente_id
    fill_in "Materia division", with: @materia_docente.materia_division_id
    check "Titular" if @materia_docente.titular
    click_on "Update Materia docente"

    assert_text "Materia docente was successfully updated"
    click_on "Back"
  end

  test "should destroy Materia docente" do
    visit materia_docente_url(@materia_docente)
    click_on "Destroy this materia docente", match: :first

    assert_text "Materia docente was successfully destroyed"
  end
end
