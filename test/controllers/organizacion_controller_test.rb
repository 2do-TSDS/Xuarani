require "test_helper"

class OrganizacionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organizacion_index_url
    assert_response :success
  end
end
