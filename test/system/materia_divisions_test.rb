require "application_system_test_case"

class MateriaDivisionsTest < ApplicationSystemTestCase
  setup do
    @materia_division = materia_divisions(:one)
  end

  test "visiting the index" do
    visit materia_divisions_url
    assert_selector "h1", text: "Materia divisions"
  end

  test "should create materia division" do
    visit materia_divisions_url
    click_on "New materia division"

    fill_in "Division", with: @materia_division.division_id
    fill_in "Materia", with: @materia_division.materia_id
    click_on "Create Materia division"

    assert_text "Materia division was successfully created"
    click_on "Back"
  end

  test "should update Materia division" do
    visit materia_division_url(@materia_division)
    click_on "Edit this materia division", match: :first

    fill_in "Division", with: @materia_division.division_id
    fill_in "Materia", with: @materia_division.materia_id
    click_on "Update Materia division"

    assert_text "Materia division was successfully updated"
    click_on "Back"
  end

  test "should destroy Materia division" do
    visit materia_division_url(@materia_division)
    click_on "Destroy this materia division", match: :first

    assert_text "Materia division was successfully destroyed"
  end
end
