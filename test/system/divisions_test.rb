require "application_system_test_case"

class DivisionsTest < ApplicationSystemTestCase
  setup do
    @division = divisions(:one)
  end

  test "visiting the index" do
    visit divisions_url
    assert_selector "h1", text: "Divisions"
  end

  test "should create division" do
    visit divisions_url
    click_on "New division"

    fill_in "Nombre", with: @division.nombre
    click_on "Create Division"

    assert_text "Division was successfully created"
    click_on "Back"
  end

  test "should update Division" do
    visit division_url(@division)
    click_on "Edit this division", match: :first

    fill_in "Nombre", with: @division.nombre
    click_on "Update Division"

    assert_text "Division was successfully updated"
    click_on "Back"
  end

  test "should destroy Division" do
    visit division_url(@division)
    click_on "Destroy this division", match: :first

    assert_text "Division was successfully destroyed"
  end
end
