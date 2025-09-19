require "test_helper"

class MateriaDocentesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @materia_docente = materia_docentes(:one)
  end

  test "should get index" do
    get materia_docentes_url
    assert_response :success
  end

  test "should get new" do
    get new_materia_docente_url
    assert_response :success
  end

  test "should create materia_docente" do
    assert_difference("MateriaDocente.count") do
      post materia_docentes_url, params: { materia_docente: { docente_id: @materia_docente.docente_id, materia_division_id: @materia_docente.materia_division_id, titular: @materia_docente.titular } }
    end

    assert_redirected_to materia_docente_url(MateriaDocente.last)
  end

  test "should show materia_docente" do
    get materia_docente_url(@materia_docente)
    assert_response :success
  end

  test "should get edit" do
    get edit_materia_docente_url(@materia_docente)
    assert_response :success
  end

  test "should update materia_docente" do
    patch materia_docente_url(@materia_docente), params: { materia_docente: { docente_id: @materia_docente.docente_id, materia_division_id: @materia_docente.materia_division_id, titular: @materia_docente.titular } }
    assert_redirected_to materia_docente_url(@materia_docente)
  end

  test "should destroy materia_docente" do
    assert_difference("MateriaDocente.count", -1) do
      delete materia_docente_url(@materia_docente)
    end

    assert_redirected_to materia_docentes_url
  end
end
