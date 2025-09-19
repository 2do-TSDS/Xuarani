require "test_helper"

class MateriaDivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @materia_division = materia_divisions(:one)
  end

  test "should get index" do
    get materia_divisions_url
    assert_response :success
  end

  test "should get new" do
    get new_materia_division_url
    assert_response :success
  end

  test "should create materia_division" do
    assert_difference("MateriaDivision.count") do
      post materia_divisions_url, params: { materia_division: { division_id: @materia_division.division_id, materia_id: @materia_division.materia_id } }
    end

    assert_redirected_to materia_division_url(MateriaDivision.last)
  end

  test "should show materia_division" do
    get materia_division_url(@materia_division)
    assert_response :success
  end

  test "should get edit" do
    get edit_materia_division_url(@materia_division)
    assert_response :success
  end

  test "should update materia_division" do
    patch materia_division_url(@materia_division), params: { materia_division: { division_id: @materia_division.division_id, materia_id: @materia_division.materia_id } }
    assert_redirected_to materia_division_url(@materia_division)
  end

  test "should destroy materia_division" do
    assert_difference("MateriaDivision.count", -1) do
      delete materia_division_url(@materia_division)
    end

    assert_redirected_to materia_divisions_url
  end
end
