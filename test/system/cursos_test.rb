require "application_system_test_case"

class CursosTest < ApplicationSystemTestCase
  setup do
    @curso = cursos(:one)
  end

  test "visiting the index" do
    visit cursos_url
    assert_selector "h1", text: "Cursos"
  end

  test "should create curso" do
    visit cursos_url
    click_on "New curso"

    fill_in "Nombre", with: @curso.nombre
    click_on "Create Curso"

    assert_text "Curso was successfully created"
    click_on "Back"
  end

  test "should update Curso" do
    visit curso_url(@curso)
    click_on "Edit this curso", match: :first

    fill_in "Nombre", with: @curso.nombre
    click_on "Update Curso"

    assert_text "Curso was successfully updated"
    click_on "Back"
  end

  test "should destroy Curso" do
    visit curso_url(@curso)
    click_on "Destroy this curso", match: :first

    assert_text "Curso was successfully destroyed"
  end
end
