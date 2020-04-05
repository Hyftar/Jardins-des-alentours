require 'test_helper'

class LandingPageTest < ActionDispatch::IntegrationTest
  test "Can see the title" do
    get "/"
    assert_response :success
    assert_select "h1", "Jardins Des Alentours"
  end

  test "Can see the map" do
    get "/"
    assert_select "#mapid"
  end

  test "Can connect to existing account" do
    sign_in
    assert_equal "/", path
  end

end
