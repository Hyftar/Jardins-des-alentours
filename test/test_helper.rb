ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module SignInHelper
  def sign_in()
    get "/auth/sign_in"
    assert_response :success
    post "/auth/sign_in", params: {'user': {'email': users(:one).email, 'password': "test12345"}}
    follow_redirect!
  end

  def sign_in_admin()
    get "/auth/sign_in"
    assert_response :success
    post "/auth/sign_in", params: {'user': {'email': users(:two).email, 'password': "test12345"}}
    follow_redirect!
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
