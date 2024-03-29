require 'test_helper'

class EmailBansTest < ActionDispatch::IntegrationTest

  test "List email bans" do
    sign_in_admin
    get "/email_bans"
    assert_select "td", {count: 1, text: "123@example.com"}
  end

  test "Create email ban" do
    sign_in_admin
    post "/email_bans/create", params: {'email': "test123@example.com", 'banned_until': DateTime.tomorrow, 'reason': "This is the reason"}
    follow_redirect!
    assert_select "td", {count: 1, text: "test123@example.com"}
  end

  test "Can't access email bans if not admin" do
    sign_in
    post "/email_bans/create", params: {'email': "test123@example.com", 'banned_until': DateTime.tomorrow, 'reason': "This is the reason"}
    follow_redirect!
    assert_equal '/', path
  end

end
