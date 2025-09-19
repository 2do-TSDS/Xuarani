require "test_helper"

class MateriaAlumnosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @materia_alumno = materia_alumnos(:one)
  end

  test "should get index" do
    get materia_alumnos_url
    assert_response :success
  end

  test "should get new" do
    get new_materia_alumno_url
    assert_response :success
  end

  test "should create materia_alumno" do
    assert_difference("MateriaAlumno.count") do
      post materia_alumnos_url, params: { materia_alumno: { alumno_id: @materia_alumno.alumno_id, materia_division_id: @materia_alumno.materia_division_id } }
    end

    assert_redirected_to materia_alumno_url(MateriaAlumno.last)
  end

  test "should show materia_alumno" do
    get materia_alumno_url(@materia_alumno)
    assert_response :success
  end

  test "should get edit" do
    get edit_materia_alumno_url(@materia_alumno)
    assert_response :success
  end

  test "should update materia_alumno" do
    patch materia_alumno_url(@materia_alumno), params: { materia_alumno: { alumno_id: @materia_alumno.alumno_id, materia_division_id: @materia_alumno.materia_division_id } }
    assert_redirected_to materia_alumno_url(@materia_alumno)
  end

  test "should destroy materia_alumno" do
    assert_difference("MateriaAlumno.count", -1) do
      delete materia_alumno_url(@materia_alumno)
    end

    assert_redirected_to materia_alumnos_url
  end
end
