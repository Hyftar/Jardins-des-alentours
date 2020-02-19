require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not create user without first and last name" do
    user = User.new
    user.email = 'john@exemple.com'
    user.password = 'test123'
    assert_not user.save
  end

  test "should not create user without email" do
    user = User.new
    user.first_name = 'John'
    user.last_name = 'Doe'
    user.password = 'test123'
    assert_not user.save
  end

  test "should be able to create user with valid info" do
    user = User.new
    user.first_name = 'John'
    user.last_name = 'Doe'
    user.email = 'john@exemple.com'
    user.password = 'test123'
    assert user.save
  end

  test "should not be able to create user with invalid first name" do
    user = User.new
    user.first_name = 'J'
    user.last_name = 'Doe'
    user.email = 'john@exemple.com'
    user.password = 'test123'
    assert_not user.save
  end

  test "should not be able to create user with invalid last name" do
    user = User.new
    user.first_name = 'John'
    user.last_name = 'D'
    user.email = 'john@exemple.com'
    user.password = 'test123'
    assert_not user.save
  end
end
