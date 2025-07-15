require "application_system_test_case"

class DocentesTest < ApplicationSystemTestCase
  setup do
    @docente = docentes(:one)
  end

  test "visiting the index" do
    visit docentes_url
    assert_selector "h1", text: "Docentes"
  end

  test "should create docente" do
    visit docentes_url
    click_on "New docente"

    fill_in "Perfil", with: @docente.perfil_id
    click_on "Create Docente"

    assert_text "Docente was successfully created"
    click_on "Back"
  end

  test "should update Docente" do
    visit docente_url(@docente)
    click_on "Edit this docente", match: :first

    fill_in "Perfil", with: @docente.perfil_id
    click_on "Update Docente"

    assert_text "Docente was successfully updated"
    click_on "Back"
  end

  test "should destroy Docente" do
    visit docente_url(@docente)
    click_on "Destroy this docente", match: :first

    assert_text "Docente was successfully destroyed"
  end
end
