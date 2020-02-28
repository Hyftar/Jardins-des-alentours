require 'test_helper'

class MarketControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get market_edit_url
    assert_response :success
  end

  test "should get delete" do
    get market_delete_url
    assert_response :success
  end

end
