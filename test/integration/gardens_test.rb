require 'test_helper'

class GardensTest < ActionDispatch::IntegrationTest
  test "Can see the index page" do
    get "/gardens"
    assert_response :success
    assert_select "#map_garden"
  end

  test "Can see a garden page" do
    get "/gardens/" + gardens(:one).id.to_s
    assert_response :success
  end

  test "Can get to the market edit page" do
    sign_in
    get "/gardens/" + gardens(:one).id.to_s + "/edit"
    assert_equal 200, status
    assert_equal '/gardens/' + gardens(:one).id.to_s + '/edit', path
  end

  test "Can edit a market" do
    sign_in
    post "/gardens/" + gardens(:one).id.to_s, params: {'_method': 'patch', 'garden': {'name': "edited name", 'description': "edited description"}}
    follow_redirect!
    assert_equal "/gardens/" + gardens(:one).id.to_s, path
    assert_select "h1", {count: 0, text: gardens(:one).name}
    assert_select "h1", {count: 1, text: "edited name"}
    assert_select "p", {count: 1, text: "Description : edited description"}
  end

end
