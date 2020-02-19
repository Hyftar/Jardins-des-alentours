require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "should be able to create a new role and add it to a user" do
    user = users(:one)
    role = Role.create(name: 'test_role')
    user.roles << role
    assert_equal 'test_role', user.roles.first.name
  end

  test "should not be able to save role without name" do
    role = Role.new
    assert_not role.save
  end

  test "Jane Doe should have two valid roles" do
    user = users(:two)
    assert_equal ['Admin', 'Curator'], user.roles.map(&:name)
  end

  test "should not be able to save role with name shorter than 3 characters" do
    role = Role.new
    role.name = 'aa'
    assert_not role.save
  end

  test "should not be able to save role with name longer than 50 characters" do
    role = Role.new
    role.name = 'dsyhjgdsfghashjkfgsafhjksgfkjasgfkjaksjfhsakjfhsjsiodgsg'
    assert_not role.save
  end

  test "should be able to save valid role" do
    role = Role.new
    role.name = 'test_role_123'
    assert role.save
  end
end
