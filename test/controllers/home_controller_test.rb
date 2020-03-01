require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get home_index" do
    get ""
    assert_response :success
  end
end
