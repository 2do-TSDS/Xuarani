require "test_helper"

class CargaXlsxControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get carga_xlsx_index_url
    assert_response :success
  end
end
