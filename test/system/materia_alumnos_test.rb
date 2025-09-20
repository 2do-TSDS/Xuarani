require "application_system_test_case"

class MateriaAlumnosTest < ApplicationSystemTestCase
  setup do
    @materia_alumno = materia_alumnos(:one)
  end

  test "visiting the index" do
    visit materia_alumnos_url
    assert_selector "h1", text: "Materia alumnos"
  end

  test "should create materia alumno" do
    visit materia_alumnos_url
    click_on "New materia alumno"

    fill_in "Alumno", with: @materia_alumno.alumno_id
    fill_in "Materia division", with: @materia_alumno.materia_division_id
    click_on "Create Materia alumno"

    assert_text "Materia alumno was successfully created"
    click_on "Back"
  end

  test "should update Materia alumno" do
    visit materia_alumno_url(@materia_alumno)
    click_on "Edit this materia alumno", match: :first

    fill_in "Alumno", with: @materia_alumno.alumno_id
    fill_in "Materia division", with: @materia_alumno.materia_division_id
    click_on "Update Materia alumno"

    assert_text "Materia alumno was successfully updated"
    click_on "Back"
  end

  test "should destroy Materia alumno" do
    visit materia_alumno_url(@materia_alumno)
    click_on "Destroy this materia alumno", match: :first

    assert_text "Materia alumno was successfully destroyed"
  end
end
